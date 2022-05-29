---
layout: post
title: "Cloud Foundry v2: What's New?"
date: 2013-06-14 20:38
comments: true
categories: 
- Cloud Foundry
---

I've mentioned Cloud Foundry v2 a <a href="http://catdevrandom.me/blog/2013/05/16/buildpacks-in-cloud-foundry-v2/" target="_blank">few</a> <a href="http://catdevrandom.me/blog/2013/05/20/nise-bosh-a-new-way-to-bosh/" target="_blank">times</a> <a href="http://catdevrandom.me/blog/2013/05/21/introducing-nise-bosh-vagrant/" target="_blank">before</a>, but I wanted to really get my hands dirty with the new bits and pieces before I wrote about it. <a href="https://twitter.com/andypiper" target="_blank">Andy Piper</a> wrote about CFv2 a bit on his <a href="http://andypiper.co.uk/2013/06/07/busy-times-but-lets-talk-cloud-foundry/" target="_blank">blog</a>, in which he outlines the major features to users of CF. I wanted to dig a bit deeper into the major changes in some of the components that make up CFv2.

Router
------

The router has been completely rewritten. It used to rely on Lua scripts tied into Nginx that called out to ruby code, which limited the more advanced webapp technologies such as websockets, quite possible the feature I've seen most requested around the Cloud Foundry community. In CFv2, the router has been rewriten and replaced by <a href="https://github.com/cloudfoundry/gorouter" target="_blank">gorouter</a>, an implimentation written entirely in Go.

From the <a href="http://docs.cloudfoundry.com/docs/running/architecture/router.html" target="_blank">CFv2 docs</a>:

> Implementing a custom router in Go gives full control over every connection to the router, which makes it easier to support WebSockets and other types of traffic (e.g. via HTTP CONNECT). All routing logic is contained in a single process, removing unnecessary latency.

DEA and Stager
--------------

The DEA and Stager also recevied major facelifts. The biggest of these is probably the fact that the Stager is no longer a seperate component, but is now a function of the DEA. There's a few other big changes to the DEA as well:

- **Buildpacks** - I've writen about this <a href="http://catdevrandom.me/blog/2013/05/16/buildpacks-in-cloud-foundry-v2/" target="_blank">before</a>. I'm still very excited for this and what it means for the new types of applications that can be ran on top of Cloud Foundry
- <a href="http://docs.cloudfoundry.com/docs/running/architecture/warden.html" target="_blank">**Warden**</a> - Manages containers for both apps that are running, as well as those being used to stage applications. This handles isolation of CPU, memory, network usage, disk usage, etc.
- **The new staging process** - With the Stager being absorbed into the DEA, apps are now staged on the same environment they're going to be ran on, all the way to the point of being staged in a Warden container like they'll be in when they run. Read more in the <a href="http://docs.cloudfoundry.com/docs/running/architecture/how-applications-are-staged.html" target="_blank">CFv2 docs</a>.
- **Stacks** - Think of these sort of like "tags" for your DEAs. This allows you to run a mix of DEAs with different characteristics, as minute as perhaps a certain package installed on the DEA, to as extreme as being a completely different OS. When the user pushes up the application, they can specify what stack they require, and CF will ensure the app runs on a DEA marked with the same stack.

Cloud Controller
----------------

The Cloud Controller now has several key changes.

**Organizations and Spaces**, for example, is a way to allow access to applications between multiple users. This means if you have more than one operations person in charge of managing an application on Cloud Foundry, you no long need to share credentials. Organizations and Spaces can be arranged in several ways. For example, you may choose to have an Org for each project and a Space for each phase of the development cycle (dev, staging, prod for example). Consider the diagram below from the CFv2 docs:

<center>{% img /images/cloudfoundry/org-space-arch.png %}</center>

As you can see, the hierarchy is simple to follow. Organizations contain one or more space, and spaces contain zero or more applications. 

**Routes and Domains** are another change in app management. Cloud Foundry has always had the ability to use external domains, that is, domains that are different from the domain that the API endpoint is on, but it was up to the service provider to enable this. cloudfoundry.com, for example, did not have this enabled, while AppFog did. CFv2 adds the ability for users to register custom domains, and map them to one or more space or domain. So while the default domain for an application on CFv2's new hosted solution might be "cfapps.io", I could easily map the "catdevrandom.me" domain to my org and host this blog on it.

To define the terms "route" and "domain", domains are the root part of the URL used in the app's URL. In the above example, both "cfapps.io" and "catdevrandom.me" would be domains. When you deploy an application, you choose a hostname that's prepended to the domain to create the full URL, or "route". So if I deploy the app "mycoolapp" and choose the domain "cfapps.io", my "route" would be the full URL of "mycoolapp.cfapps.io".

The cf CLI
----------

In CFv1, you managed all of your applications from the command line using the "vmc" CLI. It was a ruby gem that contained all of the logic to interact with the Cloud Controller REST API and allowed you to create and manage applications. "cf" comes in and replaces vmc. It's still installed as a ruby gem but has been updated to handle all of the new features for CFv2. There's too many commands to list in this blog, so I'll just point you to the <a href="http://docs.cloudfoundry.com/docs/using/managing-apps/cf/index.html" target="_blank">CFv2 docs</a> once again.

Conclusion
----------
I've been in the CF community for quite some time now, but this is the most exciting time for us. CFv2 brings some major changes to the table, including some long-requested features. There's still more goodies for us as a community in CFv2, and I havn't even mentioned BOSH in the slightest, but that's for another blog post.

Reference
---------
- <a href="http://docs.cloudfoundry.com/" target="_blank">Cloud Foundry Documentation</a>