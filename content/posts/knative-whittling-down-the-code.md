---
title: "Knative: Whittling Down the Code"
date: 2019-01-14T09:56:06-05:00
draft: false
tags: 
  - knative
  - container
  - serverless
image: http://d2dqcpbw60t2h9.cloudfront.net/img/wood-shavings.jpg
summary: Let's take a look at how we can whittle down the amount of both code and configuration we write with Knative and Project riff
---

Hands down, the open-source project I've been most in love with to come out of 2018 has been Knative, a serverless platform built on top of Kubernetes. Not just as an open source serverless platform, but for the entire development paradigm that it encourages. Event-driven development isn’t new, but Knative lays the groundwork to build an ecosystem around eventing. If you’re not familiar with Knative, any documentation you read on it will break down what it is into three distinct categories:

- **Build** - How do I build my code and get it into a runnable state?
- **Serving** - How do I serve requests to my code? How does it scale up and down?
- **Eventing** - How can my code be triggered by various events?

Now, this isn't meant to be a "Getting Started With Knative" post (more on that later), but what I've been thinking about most lately is how developers can whittle down their code as they leverage more and more of what Knative has to offer. This has been an especially hot topic on Twitter as of late, especially around the time of KubeCon, where some question if you're writing a Dockerfile, is it really a serverless platform? Others, though, feel like packaging your code as a container may even be the most logical solution. It's portable, it's comprehensive, it has all of your dependencies. There's no shortage of strongly-held opinions by people oh-so-eager to argue them when it comes to this topic. Instead of adding fuel to this fire, let's simply take a look at what options Knative gives developers, and gradually work down the amount of code we're writing. We’ll start with the most verbose example where we build a prebuilt container that we build ourselves. From there we’ll whittle down our codebase down smaller and smaller, removing the need to build our own container, then removing the need to write our own Dockerfile, and finally remove the need to write our own configuration.

All of the code we'll look at are in two git repos: [knative-hello-world](https://github.com/BrianMMcClain/knative-hello-world) and [riff-hello-world](https://github.com/BrianMMcClain/riff-hello-world).

Prebuilt Docker Container
---

The first scenario we'll look at is if we were to provide Knative a prebuilt container image, already uploaded to our container registry of choice. Most [Hello World](https://github.com/knative/docs/tree/master/serving/samples/helloworld-nodejs) samples you'll see with Knative take the route of building and managing the container directly. It makes sense since it's easy to digest and doesn't introduce many new concepts, making it a great place to start. The concept is straight forward: You give Knative a container that exposes a port, and it will handle everything else. It doesn't care if your code is written in [Go](https://github.com/knative/docs/tree/master/serving/samples/helloworld-go), or [Ruby](https://github.com/knative/docs/tree/master/serving/samples/helloworld-ruby), or [Rust](https://github.com/knative/docs/tree/master/serving/samples/helloworld-rust), it will just take requests coming in and send them to your app. Let's start with a basic node.js hello world app that uses the [Express web framework](https://expressjs.com/).

```js
const express = require("express");
const bodyParser = require('body-parser')

const app = express();
app.use(bodyParser.text({type: "*/*"}));

app.post("/", function(req, res) {
  res.send("Hello, " + req.body + "!");
});

const port = process.env.PORT || 8080;
app.listen(port, function() {
  console.log("Server started on port", port);
});
```

Nice and straightforward. This code will setup a webserver, listen on port 8080 (unless the PORT environment variable says otherwise), and respond to HTTP POST requests by saying Hello. Of course there's the package.json file that defines a few things (how to start the app, dependencies, etc) but that's a bit outside of the scope of what we're looking at. Of course, the other half of this is the Dockerfile that describes how to package it all up into a container.

```dockerfile
FROM node:8.14.0-stretch-slim

WORKDIR /usr/src/app
COPY . .
RUN npm install

ENV PORT 8080
EXPOSE $PORT

ENTRYPOINT ["npm", "start"]
```

Again, nothing surprising here. We base our image off of the official node.js image, copy our code to the container and install the dependencies, then tell it how to run our app. All that's left is to upload it to Docker Hub.

```bash
$ docker build . -t brianmmcclain/knative-hello-world:prebuilt

$ docker push brianmmcclain/knative-hello-world:prebuilt
```


All of this looks very familiar if you've ever ran an application on something like Kubernetes, right? Toss your code in a container and let the scheduler deal with making sure it stays up. We can actually tell Knative about this container, plus a little bit of metadata, and it will handle everything from there. Scale up the number of instances as the number of requests grows, scale to zero, routing requests, wiring up events, the whole nine yards. All we really need to tell Knative about is what to call our app, what namespace to run it in and where the container image lives.

```yaml
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: knative-hello-world-prebuilt
  namespace: default
spec:
  runLatest:
    configuration:
      revisionTemplate:
        spec:
          container:
            image: docker.io/brianmmcclain/knative-hello-world:prebuilt
```

```bash
$ kubectl apply -f 01-prebuilt.yaml
```

A few moments later, we'll see a new pod spin up, ready to serve requests, and eventually scale back down to zero after a little while of not receiving any traffic. We can POST some data and see our response. First let's get the ingress IP to our Kubernetes cluster and assign it to the `$SERVICE_IP` variable:

```bash
$ export SERVICE_IP=`kubectl get svc knative-ingressgateway -n istio-system -o jsonpath="{.status.loadBalancer.ingress[*].ip}"`
```

And then use the IP to send a request to our service, setting the `Host` header in our request:

```bash
$ curl -XPOST http://$SERVICE_IP -H "Host: knative-hello-world-prebuilt.default.example.com" -d "Prebuilt"

Hello, Prebuilt!
```

The Kaniko Container Builder
---

So that was all well and good, but we haven't even begun to touch the "Build" part of Knative. Literally, we didn't touch it, we built it on our own. You can [read all about builds](https://github.com/knative/docs/tree/master/build) and how they work in the Knative docs, which by the way are very comprehensive. In short though, Knative has a concept called ["Build Templates"](https://github.com/knative/docs/blob/master/build/build-templates.md), and how I like to describe them is that they are the sharable logic on how to go from code to container. Most of these build templates will remove the need for us to build our own container or upload it to a container registry. The most basic of these is probably the [Kaniko Build Template](https://github.com/knative/build-templates/tree/master/kaniko).

As the name might suggest, it's based off of Google's [Kaniko](https://github.com/GoogleContainerTools/kaniko), a tool for building container images inside a container, with no dependency on a running Docker daemon. You feed the Kaniko container image your Dockerfile and a place to upload the result and it spits out a container image. Instead of pulling down our code, building our container locally, uploading it to Docker Hub and then pulling it back down into Knative, we can have Knative do this all for us with just a little bit more configuration.

Before we do this though, we need to tell Knative how to authenticate against our container registry. To do this, we'll first need to create a secret in Kubernetes so that we can authenticate to Docker Hub, and then create a service account to use that secret and run our build. Let's start by creating the secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: dockerhub-account
  annotations:
    build.knative.dev/docker-0: https://index.docker.io/v1/
type: kubernetes.io/basic-auth
data:
  # 'echo -n "username" | base64'
  username: dXNlcm5hbWUK
  # 'echo -n "password" | base64'
  password: cGFzc3dvcmQK
```

Our username and password are sent to Kubernetes as base64-encoded strings (for the security minded folks reading, this is a transport mechanism, not a security one. For more information on how Kubernetes stores secrets, make sure to check out the docs on [encrypting secret data at rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)). Once applied, we'll then create a service account named `build-bot` and tell it to use this secret when pushing to Docker Hub:

```yaml
 apiVersion: v1
 kind: ServiceAccount
 metadata:
   name: build-bot
 secrets:
 - name: dockerhub-account
 ```

For more information on authentication, make sure to check out the [how authentication works in Knative](https://github.com/knative/docs/blob/master/build/auth.md) doc.

The nice thing about Build Templates is that anyone can create and share them with the community. We can tell Knative to install this Build Template by passing it, you guessed it, some YAML:

```bash
$ kubectl apply -f https://raw.githubusercontent.com/knative/build-templates/master/kaniko/kaniko.yaml
```

Then we need to add a little but more the our app's YAML:

```yaml
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: knative-hello-world-kaniko
  namespace: default
spec:
  runLatest:
    configuration:
      build:
        serviceAccountName: build-bot
        source:
          git:
            url: https://github.com/BrianMMcClain/knative-hello-world.git
            revision: master
        template:
          name: kaniko
          arguments:
          - name: IMAGE
            value: docker.io/brianmmcclain/knative-hello-world:kaniko
      revisionTemplate:
        spec:
          container:
            image: docker.io/brianmmcclain/knative-hello-world:kaniko
```

While it's a bit hard to compare directly, we've actually only added one section to our YAML, the "build" section. What we've added might seem like a lot, it's actually not bad when you take the time to look at it piece by piece.

- **serviceAccountName** - In the Knative auth docs, it walks through the process of setting up a service account. All this is though is setting up a Kubernetes secret that can authenticate to our container image repository, and then encapsulating it in a service account.
- **source** - Where our code lives, for example, a git repository.
- **template** - Which build template to use, in our case we'll use the kaniko build template. 

Let's send a request to the new version of our application to make sure everything is still in order:

```bash
$ curl -XPOST http://$SERVICE_IP -H "Host: knative-hello-world-kaniko.default.example.com" -d "Kaniko"

Hello, Kaniko!
```

So while this may be a bit more upfront configuration, the tradeoff is that now we don't have to build or push our own container image each time we update our code. Instead, Knative will handle these steps for us!

The Buildpack Build Template
---

So the whole point of this blog is how we can write less code. While we’ve removed an operation component of our deployments with the Kaniko Build Template, we’re still maintaining a Dockerfile and a configuration file on top of our code. What if we could ditch the Dockerfile in our code?

If you come from a PaaS background, you're probably used to simply pushing up your code, some magic happens, and suddenly you have a working application. You don't care how this is accomplished, you don't have to write up a Dockerfile to get it into a container, it just works. In [Cloud Foundry](https://www.cloudfoundry.org/), this is done with something called [buildpacks](https://docs.cloudfoundry.org/buildpacks/), a framework for providing the runtime and dependencies to your application.

We actually luck out twice here. Not only is there a build template to use buildpacks, there's also a buildpack for Node.js. Just like the Kaniko Build Template, we'll install the buildpack Build Template in Knative:

```bash
kubectl apply -f https://raw.githubusercontent.com/knative/build-templates/master/buildpack/buildpack.yaml
```

Now, let's take a look at what our YAML looks like using the Buildpack Build Template:

```yaml
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: knative-hello-world-buildpack
  namespace: default
spec:
  runLatest:
    configuration:
      build:
        serviceAccountName: build-bot
        source:
          git:
            url: https://github.com/BrianMMcClain/knative-hello-world.git
            revision: master
        template:
          name: buildpack
          arguments:
          - name: IMAGE
            value: docker.io/brianmmcclain/knative-hello-world:buildpack
      revisionTemplate:
        spec:
          container:
            image: docker.io/brianmmcclain/knative-hello-world:buildpack
  ```

This is _very_ similar to when we used the Kaniko build template. In fact, let's diff the two.

```
<   name: knative-hello-world-kaniko
>   name: knative-hello-world-buildpack
---
<           name: kaniko
>           name: buildpack
---
<             value: docker.io/brianmmcclain/knative-hello-world:kaniko
>             value: docker.io/brianmmcclain/knative-hello-world:buildpack
---
<             image: docker.io/brianmmcclain/knative-hello-world:kaniko
>             image: docker.io/brianmmcclain/knative-hello-world:buildpack
```

So then what's the difference? Well, for starters, we can completely ditch our Dockerfile. The Buildpack Build Template will analyze our code, see that it's a Node.js application, and build a container for us by downloading the Node.js runtime and our dependencies. While the Kaniko Build Template freed us up from managing the Docker container lifecycle, the Buildpack Build Template removes the need to manage the Dockerfile at all.

```bash
$ kubectl apply -f 03-buildpack.yaml
service.serving.knative.dev "knative-hello-world-buildpack" configured

$ curl -XPOST http://$SERVICE_IP -H "Host: knative-hello-world-buildpack.default.example.com" -d "Buildpacks"
Hello, Buildpacks!
```

Project riff
---

Let's take stock of what remains of our codebase. We have our Node code that responds to POST requests, using the Express framework to setup a webserver. The package.json and package.json files define our dependencies. Not exactly code, but we're also maintaining our YAML that defines our Knative service. What if we could ditch that part altogether?

Enter [Project riff](https://projectriff.io/), an open source project built on top of Knative. Project riff aims to remove the need to manage anything other than your code. That includes the webserver we've been managing ourselves in our codebase. That means now our code looks like this:

```js
module.exports = x => "Hello, " + x + "!";
```

That's it. No Dockerfile, no YAML, just one line of code. Of course like every good Node developer we still have our package.json file, albeit it without the dependency on Express, but riff will take this one line of code, wrap it up in it's own managed base container image, package it together with the [Node function invoker](https://github.com/projectriff/node-function-invoker), and serve it up like any other function running on Knative. 

Before we can deploy this function, there is a one-time setup we'll need to do with riff. Though the [riff CLI](https://github.com/projectriff/riff) can install all of Knative for us, since we have it installed we'll simply tell riff which secret to use when pushing up our container image to Docker Hub, and initialize our namespace with riff's Build Templates. Since we already have our secret pair from earlier named `dockerhub-account`, we'll initialize the Default namespace in Kubernetes with it:

```bash
riff namespace init default --secret dockerhub-account
```

Then it's just a matter of deploying our function. We'll tell riff to name it `riff-hello-world`, give it the link to our GitHub repository where our code lives, and tell it to upload the resulting container image to Docker Hub at brianmmcclain/riff-hello-world:

```bash
riff function create riff-hello-world --git-repo https://github.com/BrianMMcClain/riff-hello-world.git --image brianmmcclain/riff-hello-world --verbose
```

A few moments later we'll see our function up and running, which we can send requests to like any other Knative function:

```bash
$ curl -XPOST http://$SERVICE_IP -H "Host: riff-hello-world.default.example.com" -H "Content-Type: text/plain" -d "riff"

Hello, riff!
```

Or, even easier, use the riff CLI to invoke our function:

```bash
$ riff service invoke riff-hello-world --text -- -d "riff CLI"

Hello, riff CLI!
```

There we have it! Upwards 23 lines of YAML, 14 lines of code and a 10 line Dockerfile reduced down to 1 simple line of code.

What's Next?
---

To me, one of the most exciting features of Knative is Build Templates. It has so much potential to open up a community of custom-built templates for all sorts of scenarios. Already there exists templates for tools like [Jib](https://github.com/knative/build-templates/tree/master/jib) and [BuildKit](https://github.com/knative/build-templates/tree/master/buildkit). There's already a [pull request](https://github.com/knative/build-templates/pull/67) to update the [Buildpack](https://github.com/knative/build-templates/tree/master/buildpack) build template to support [Cloud Native Buildpacks](https://buildpacks.io/) which is a whole world of other possibilities. 2018 was an exciting start, but I'm even more excited to see the Knative community grow in 2019.
