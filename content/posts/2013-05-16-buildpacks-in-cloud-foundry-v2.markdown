---
title: "Buildpacks in Cloud Foundry v2"
date: 2013-05-16
comments: true
tags: 
- Cloud Foundry
- PaaS
- Haskell
- Code
- Buildpacks
---

The above tweet summarizes a very productive and exciting lunch I had today, in which after getting CF v2 working last night thanks to <a href="https://github.com/nttlabs/nise_bosh" target="_blank">nise_bosh</a>, I started reading about buildpacks.

To summarize buildpacks, taken straight from the <a href="http://docs.cloudfoundry.com/docs/using/deploying-apps/custom/" target="_blank">Cloud Foundry documentation</a>...


> Buildpacks are a convenient way of packaging framework and/or runtime support for your application. For example, Cloud Foundry doesn't support Django or Python by default. Using a buildpack for Python and Django would allow you to add support for these at the deployment stage.

These are very much the same as the buildpacks you're familiar with if you've ever used <a href="https://devcenter.heroku.com/articles/buildpacks" target="_blank">Heroku</a>. In Cloud Foundry v1, to add a framework or runtime, you modified the actual CF source code, submitted a pull request, and it would get merged into the main repo. However, buildpacks plug right into Cloud Foundry v2. You don't need to write any code other than the buildpack itself. You don't need anyone's permission and you don't have to wait for a code review.

So how easy are buildpacks to create and use? Well, I decided to do a little experiment to figure this out for myself. I chose to pick a runtime I'm almost completely unfamiliar with: Haskell.

<center>{% img /images/haskell/lyah.png 300 400 %}</center>

I say <i>almost</i> because I had a brief stint of learning Haskell using the above publication. I had fun, but didn't have enough time to dedicate to learning it.

So after a quick search, I found there was a Heroku buildpack for Haskell that already existed, which can be found <a href="https://github.com/puffnfresh/heroku-buildpack-haskell" target="_blank">here</a>. Awesome, this is exactly what I was hoping for. I had no context of what was needed to build the buildpack other than knowledge of bash, and there was an existing one I could adapt as needed. I took the <a href="https://github.com/puffnfresh/haskell-buildpack-demo" target="_blank">demo app</a>, and tried to deploy it with no modifications...

{% codeblock %}
➜ cf push hasktest --buildpack=git://github.com/puffnfresh/heroku-buildpack-haskell.git

Creating route haskelltest.cfv2.dev... OK
Binding haskelltest.cfv2.dev to hasktest... OK
Uploading hasktest... OK
Starting hasktest... OK
-----> Downloaded app package (4.0K)
Initialized empty Git repository in /tmp/buildpacks/heroku-buildpack-haskell.git/.git/
Installing heroku-buildpack-haskell.git.
-----> Downloading GHC
######################################################################## 100.0%
-----> Downloading Cabal
######################################################################## 100.0%
-----> Updating Cabal
/tmp/buildpacks/heroku-buildpack-haskell.git/bin/compile: line 48: cabal: command not found
/var/vcap/packages/dea_next/buildpacks/lib/installer.rb:17:in `compile': Buildpack compilation step failed: (RuntimeError)
	from /var/vcap/packages/dea_next/buildpacks/lib/buildpack.rb:26:in `block in compile_with_timeout'
	from /usr/lib/ruby/1.9.1/timeout.rb:68:in `timeout'
	from /var/vcap/packages/dea_next/buildpacks/lib/buildpack.rb:25:in `compile_with_timeout'
	from /var/vcap/packages/dea_next/buildpacks/lib/buildpack.rb:16:in `block in stage_application'
	from /var/vcap/packages/dea_next/buildpacks/lib/buildpack.rb:12:in `chdir'
	from /var/vcap/packages/dea_next/buildpacks/lib/buildpack.rb:12:in `stage_application'
	from /var/vcap/packages/dea_next/buildpacks/bin/run:10:in `<main>'
Checking hasktest...
Application failed to stage
{% endcodeblock %}

Aaaaaand crash.

Ok, so, it needs a little work. And I mean literally that, little work. I did the open-source coder's favorite thing and pressed the big ole' "Fork" button. You can find my fork <a href="https://github.com/BrianMMcClain/heroku-buildpack-haskell" target="_blank">here</a>. As you can see from the <a href="https://github.com/BrianMMcClain/heroku-buildpack-haskell/compare/22382e2ec9ccdf63cb802df96385d0743dcffbe0...a3cc2ca860a5586510fb509e32d61be30452e40c" target="_blank">commits</a>, hardly any work needed done to get things working, and sure enough...


{% codeblock %}
➜ cf push hasktest --buildpack=git://github.com/BrianMMcClain/heroku-buildpack-haskell.git

Starting hasktest... OK
-----> Downloaded app package (4.0K)
Initialized empty Git repository in /tmp/buildpacks/heroku-buildpack-haskell.git/.git/
Installing heroku-buildpack-haskell.git.
-----> Downloading GHC
######################################################################## 100.0%
-----> Downloading Cabal
######################################################################## 100.0%
-----> Updating Cabal
Config file path source is default config file.
Config file /home/vcap/.cabal/config not found.
Writing default configuration to /home/vcap/.cabal/config
Downloading the latest package list from hackage.haskell.org
Note: there is a new version of cabal-install available.
To upgrade, run: cabal install cabal-install
-----> Release the hounds! Installing application
Resolving dependencies...
Downloading base-unicode-symbols-0.2.2.4...
[... lots and lots of stuff ...]
Downloading warp-1.3.8.1...
Configuring warp-1.3.8.1...
Building warp-1.3.8.1...
Installed warp-1.3.8.1
Configuring heroku-haskell-0.1.0.0...
Building heroku-haskell-0.1.0.0...
Installed heroku-haskell-0.1.0.0
-----> Caching Cabal packages
/app/.ghc
Cache dir size:
399	/tmp/cache
Build dir size:
8	/tmp/staged/app
-----> Uploading staged droplet (1.7M)
-----> Uploaded droplet
Checking hasktest...
  0/1 instances: 1 starting
  1/1 instances: 1 running
OK
{% endcodeblock %}

That's. It. 

<center>{% img /images/cloudfoundry/hasktest.png %}</center>

Cloud Foundry v2 is proving to refine the PaaS that I'm a huge fan of, and I can't wait to dig up other new features. <a href="https://twitter.com/andypiper" target="_blank">Andy Piper</a> wrote up a nice <a href="http://andypiper.co.uk/2013/05/16/cloud-foundry-has-gone-pivotal-so-whats-new/" target="_blank">blog post</a> today on the move from Cloud Foundry to Pivotal, as well Cloud Foundry v2 and BOSH. It's a good read, and I highly recommend you do.