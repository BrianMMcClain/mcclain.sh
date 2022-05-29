---
layout: post
title: "Hacking on Cloud Foundry's Gorouter"
date: 2014-05-12 22:39
comments: true
categories: 
- Cloud Foundry
- gorouter
- Go
---

Late last week, a couple colleagues and myself discovered a small bug in Cloud Foundry's [gorouter](https://github.com/cloudfoundry/gorouter) in which a websocket upgrade was not completed if a comma-separated list of values in the Connection header was provided. A [pull request](https://github.com/cloudfoundry/gorouter/pull/39) was pieced together, submitted and is currently being looked at by Pivotal. However, I figured, why let the learning stop there?

There were several things that I was unfamiliar with:

1. The gorouter codebase
2. Running the gorouter locally
3. The Go language

Obviously, I had my work cut out for me. Luckily, Go proved to have a very forgiving learning curve, but that's for a future post. That only other thing in my way was getting familiar with Go itself, but first, let's explore the issue at hand.


The App
-------

We boiled it down to an extremely simple example. So simple, in fact, that we pulled the code straight from the [sinatra-websocket](https://github.com/simulacre/sinatra-websocket) README. The only addition was a bit of extra logging to dump the headers on each request.


The Issue
---------

We were observing that the sample app worked perfectly fine in Chrome, but not in Firefox. Obviously, this meant a difference in how the websocket upgrade was being handled between the two browsers. After a bit of trial and error, we noticed the difference in the headers being sent. There's two requests here, the first is the HTTP GET / to get the static page, and the second is the protocol switch.

Let's take a look at the headers from Chrome:

```
200 OK
Connection: keep-alive
Upgrade:

101 Switching Protocols
Connection: Upgrade
Upgrade: websocket
```

And the headers from Firefox

```
200 OK
Connection: keep-alive
Upgrade:

200 OK
Connection: keep-alive, Upgrade
Upgrade: websocket
```

Notice the difference? As you can see, Firefox is providing a comma-separated list of values for the Connection header. According to [RFC 2616 section 4.2](http://tools.ietf.org/html/rfc2616#section-4.2), this is perfectly valid:

<blockquote>
Multiple message-header fields with the same field-name MAY be present in a message if and only if the entire field-value for that header field is defined as a comma-separated list [i.e., #(values)]. It MUST be possible to combine the multiple header fields into one "field-name: field-value" pair, without changing the semantics of the message, by appending each subsequent field-value to the first, each separated by a comma.
</blockquote>

However after digging through the gorouter code, we see the following [method for handling the check if the header contains an upgrade request](https://github.com/cloudfoundry/gorouter/blob/74813aa9292d26fdd70f691dd7f501e7ea0a88d1/proxy/proxy.go#L301-L308):

```
func upgradeHeader(request *http.Request) string {
  // upgrade should be case insensitive per RFC6455 4.2.1
  if strings.ToLower(request.Header.Get("Connection")) == "upgrade" {
    return request.Header.Get("Upgrade")
  } else {
    return ""
  }
}
```

I hadn't had much experience with Go prior to this, but it doesn't take much expertise to find the small issue. The gorouter is checking if the value of the Connection header only contains the string "Upgrade". This means that our comma-separated string in our Connection header is returning false on this comparison, and it's not recognized as a websocket upgrade. Easy enough mistake to make (in fact, this issue is what caused me to learn about what I quoted from the RFC doc above), but lucky for us, easy enough to fix!


The Fix
-------

The last bit of lead-up until we hit on the true point of this post is the actual code fix. What we want to do is split the string on commas and compare each value, rather than the entire header itself. You can see the same code below in the PR I've made to the gorouter:

```
func upgradeHeader(request *http.Request) string {
  // upgrade should be case insensitive per RFC6455 4.2.1
  for _, val := range strings.Split(strings.ToLower(request.Header.Get("Connection")), ",") {
    if strings.Trim(val, " ") == "upgrade" {
      return request.Header.Get("Upgrade")
    }
  }
  return ""
}
```

Criticize my Go skills all you like. This was written with about 20 minutes of Go knowledge. But, it got the job done. The requests from Firefox now were as follows:

```
200 OK
Connection: keep-alive
Upgrade:

101 Switching Protocols
Connection: keep-alive, Upgrade
Upgrade: websocket
```


The Tests
---------

And so we reach the true point of this article, how do we test this? There's several things we need running for this:

1. The test app
2. NATS (which Gorouter uses to know where apps are running)
3. Gorouter


Let's go in order. You can find code used for testing [on my Github](https://github.com/BrianMMcClain/sinatra-websocket-sample). Not being a tutorial on running Sinatra apps, you can simply run:

```
bundle install
ruby app.rb
```

This will start our app available on 127.0.0.1:4567

Next, we can reference the [Gorouter's README](https://github.com/cloudfoundry/gorouter/blob/master/README.md) on the other two steps. Again, not being a guide on Go, I'll assume your $GOPATH and $PATH environment variables are properly set. You can install and run NATS (or rather, gnats) with the following:

```
go get github.com/apcera/gnatsd
gnatsd
```

And if all is on your side, you'll see the following:

```
2014/05/12 22:47:46 ["Starting gnatsd version 0.5.2"]
2014/05/12 22:47:46 ["Listening for client connections on 0.0.0.0:4222"]
2014/05/12 22:47:46 ["gnatsd is ready"]
```

Finally, the router itself:

```
go get -v github.com/tools/godep
go get -v github.com/cloudfoundry/gorouter

cd $GOPATH/src/github.com/cloudfoundry/gorouter

godep restore ./...
```

This will pull the source of the gorouter to $GOPATH/src/github.com/cloudfoundry/gorouter. We'll make our changes here (in our example, it was the file at $GOPATH/src/github.com/cloudfoundry/gorouter/proxy/proxy.go), build it and run it:

```
go build
./gorouter
```

If gorouter connects to gnats, you'll see:

```
{"timestamp":1399949677.137193441,"process_id":5194,"source":"router.global","log_level":"info","message":"Connected to NATS","data":null}
{"timestamp":1399949677.140702009,"process_id":5194,"source":"common.logger","log_level":"info","message":"Component Router registered successfully","data":null}
{"timestamp":1399949677.141372442,"process_id":5194,"source":"router.global","log_level":"info","message":"Waiting 5s before listening...","data":null}
{"timestamp":1399949682.141656399,"process_id":5194,"source":"router.global","log_level":"info","message":"Listening on [::]:8081","data":null}
```


Finally, we need to tell gorouter about our app. As mentioned, gorouter listens on the NATS bus for publish messages, telling it where the apps are running. There's a few ways to do this, but I happened to have the ruby NATS tools installed, which you can install with:

```
gem install nats
```

And finally, publish a message on the NATS bus to tell gorouter about the app:

```
nats-pub router.register "{\"host\": \"127.0.0.1\",\"port\": 4567,\"uris\": [\"localhost\"],\"tags\": {}, \"Dea\": \"dea\", \"App\": \"0\"}"
```

To which you'll see the following in the gorouter logs:

```
{"timestamp":1399950032.353356123,"process_id":5194,"source":"router.global","log_level":"debug","message":"router.register: Received message","data":{"message":{"host":"127.0.0.1","port":4567,"uris":["localhost"],"tags":{},"app":"0","private_instance_id":""}}}

{"timestamp":1399950032.353794098,"process_id":5194,"source":"router.global","log_level":"debug","message":"Got router.register: \u0026{127.0.0.1 4567 [localhost] map[] 0 }","data":null}
```

However, this can be thought of as a heartbeat. This needs to be sent at regular intervals. There's a project in the Cloud Foundry Incubator called [route-registrar](https://github.com/cloudfoundry-incubator/route-registrar) to handle this, but a quick and dirty shell script will do the job as well:

```
#!/bin/bash

while :
do
    nats-pub router.register "{\"host\": \"127.0.0.1\",\"port\": 4567,\"uris\": [\"localhost\"],\"tags\": {}, \"Dea\": \"dea\", \"App\": \"0\"}"
    sleep 15
done
```


You can now finally reach the application at localhost:8081

Congrats! You now have your modified version of gorouter running and serving up requests to your app.


Closing Thoughts
----------------
Going into this, I was a bit worried. I was essentially looking to run a subset of a very complex system. However, I'm happy to see how easy it was to run only the pieces needed. This was the bug that is driving me to finally learn Go as well, so I'm hoping to contribute to the Cloud Foundry codebase, as well as discover other such ways to test individual components of the system.