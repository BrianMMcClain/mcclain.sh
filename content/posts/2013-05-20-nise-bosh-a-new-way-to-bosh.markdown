---
layout: post
title: "nise-bosh - A New Way To BOSH"
date: 2013-05-20 00:00
comments: true
categories: 
- BOSH
- nise-bosh
- vagrant
---

I mentioned <a href="https://github.com/nttlabs/nise_bosh" target="_blank">nise_bosh</a> in my previous post, albeit in passing. This is a topic, however, that deserves it's own blog post.

nise-bosh is the product of NTT, the world’s leading telecom headquartered in Tokyo, Japan. From the nise-bosh GitHub repo...

> Nise BOSH is a lightweight BOSH emulator. You can easily install multiple BOSH packages on your servers by Nise BOSH commands. 'Nise' means 'Pseudo' in Japanese.

In short, it aims to take standard BOSH releases, and allow users to install and run jobs without any instance of BOSH. 

<a href="https://twitter.com/I_Yudai" target="_blank">Iwasaki Yudai</a> of NTT detailed the details of getting CFv2 up and running using nise-bosh <a href="https://gist.github.com/yudai/5553213" target="_blank">here</a>. Most of it is prep work under the assumption of a completely clean linux box, but the important lines are the following

{% codeblock %}
sudo env PATH=$PATH bundle exec ./bin/nise-bosh -y ../cf-release ../micro.yml micro
sudo env PATH=$PATH bundle exec ./bin/nise-bosh --keep-monit-files -y ../cf-release ../micro.yml micro_ng
{% endcodeblock %}

This is installing the two jobs (micro and micro_ng) in the manifest file (micro.yml) included with the above linked gist from the cf-release BOSH release. It's a very simple and easy process, so much so that I was able to get CFv2 up and running in hardly any time, most of which was waiting for various packages to download and build.

Let's run through this with a simpler release. Not to self-promote, but the <a href="https://github.com/BrianMMcClain/mumble-release" target="_blank">mumble BOSH release</a> is very straight-forward. If you're not familiar with <a href="http://mumble.sourceforge.net/" target="_blank">mumble</a>, it's an open-source voice chat application and server. It's comparable with <a href="http://www.ventrilo.com/" target="_blank">Ventrilo</a> and <a href="http://www.teamspeak.us/" target="_blank">TeamSpeak</a>.

So let's get a fresh Ubuntu image up and running using Vagrant...

{% codeblock %}
$ vagrant init lucid64
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.


$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
[default] Importing base box 'lucid64'...
[default] Matching MAC address for NAT networking...
[default] Setting the name of the VM...
[default] Clearing any previously set forwarded ports...
[default] Creating shared folders metadata...
[default] Clearing any previously set network interfaces...
[default] Preparing network interfaces based on configuration...
[default] Forwarding ports...
[default] -- 22 => 2222 (adapter 1)
[default] Booting VM...
[default] Waiting for VM to boot. This can take a few minutes.
[default] VM booted and ready for use!
[default] Configuring and enabling network interfaces...
[default] Mounting shared folders...
[default] -- /vagrant


$ vagrant ssh
Linux lucid64 2.6.32-38-server #83-Ubuntu SMP Wed Jan 4 11:26:59 UTC 2012 x86_64 GNU/Linux
Ubuntu 10.04.4 LTS

Welcome to the Ubuntu Server!
 * Documentation:  http://www.ubuntu.com/server/doc
New release 'precise' available.
Run 'do-release-upgrade' to upgrade to it.

Welcome to your Vagrant-built virtual machine.
{% endcodeblock %}

And let's do some prep work...

{% codeblock %}
$ sudo apt-get update
$ sudo apt-get install curl git-core
$ curl -L https://get.rvm.io | bash -s stable --autolibs=enabled --ruby=1.9.3
$ source /home/vagrant/.rvm/scripts/rvm
$ gem install bundler
$ git clone https://github.com/nttlabs/nise_bosh
$ git clone https://github.com/BrianMMcClain/mumble-release.git
$ cd nise-bosh
$ bundle install
$ sudo ./bin/init
{% endcodeblock %}

Nothing fancy here. Installing some prerequisites (git, curl, ruby, bundler), grabbing the two repos of interest (nise-bosh and the BOSH release we're deploying, mumble-release), and running `bundle install` over nise-bosh. The last command is running an init script that comes with nise-bosh that takes care of a few more prerequisites. This will set up a few directories, users and groups to run the release, as well as a few other apt packages and monit.

Before we actually install the release, let's take a look at the manifest we'll be using to deploy it

{% codeblock %}
---
deployment: mumble

jobs: 
- name: mumble
  template:
  - mumble

properties:
    mumble:
        port: 64738
{% endcodeblock %}

If you've deployed BOSH releases before, you'll notice things are a lot more trimmed down here. We're only defining the jobs and properties section, and nothing as far as networks or resource pools go. I would assume you could use your normal BOSH manifest, but I can't verify that as of writing this.

One last step before deploying the release is a part of the standard BOSH deployment cycle, we need to run `bosh create release`

{% codeblock %}
cd /home/vagrant/mumble-release
gem install bosh_cli
bosh create release
cd /home/vagrant/nise_bosh
{% endcodeblock %}

Now for the main event, deploying the release. This is actually done with a single command...

{% codeblock %}
sudo -E PATH=$PATH bundle exec ./bin/nise-bosh /home/vagrant/mumble-release /home/vagrant/mumble-release/example/micro.yml mumble
{% endcodeblock %}

nise-bosh takes three arguments: The path to the BOSH release, the path of manifest file, and the name of the job to install. As you can see in our above manifest file, we have but one job listed named "mumble". The output of this is very straightforward:

{% codeblock %}
The following templates and packages for job mumble will be installed.
    # mumble
        * mumble
Do you want to continue? [Y/n]y
#[28874] INFO: Resolving package dependencies...
#[28874] INFO: Installing the following packages:
#[28874] INFO:  * mumble
#[28874] INFO: Installing package mumble
#[28874] INFO: Running the packaging script for mumble
Done!
{% endcodeblock %}

It's as simple as that. Finally, we just need to start the job. nise-bosh sets up monit config files as defined in the BOSH release, so all we need to do is tell monit to start all the jobs it's configured for...

{% codeblock %}
$ sudo /var/vcap/bosh/bin/monit start all
monit: generated unique Monit id 2561646d85b8a17eb6afa7a3ca27f756 and stored to '/root/.monit.id'
'mumble' start: /var/vcap/jobs/mumble/bin/mumble_ctl
{% endcodeblock %}

And now we have a sparkly brand-new Mumble server, as seen in the log files located at /var/vcap/sys/log/mumble

{% codeblock %}
<W>2013-05-20 19:50:40.241 Initializing settings from /var/vcap/jobs/mumble/config/murmur.ini (basepath /var/vcap/jobs/mumble/config)
<W>2013-05-20 19:50:40.241 OpenSSL: OpenSSL 0.9.8o 01 Jun 2010
<W>2013-05-20 19:50:40.253 SSL: Added CA certificates from '/etc/ssl/certs/ca-certificates.crt'
<W>2013-05-20 19:50:40.265 SSL: Adding recommended CA UTN-USERFirst-Client Authentication and Email
<C>2013-05-20 19:50:40.265 WARNING: You are running murmurd as root, without setting a uname in the ini file. This might be a security risk.
<W>2013-05-20 19:50:40.266 ServerDB: Openend SQLite database /var/vcap/jobs/mumble/config/murmur.sqlite
<W>2013-05-20 19:50:40.267 Generating new tables...
<W>2013-05-20 19:50:40.278 Resource limits were 0 0
<W>2013-05-20 19:50:40.278 Successfully dropped capabilities
<W>2013-05-20 19:50:40.306 Murmur 1.2.3 (Compiled Feb 19 2011 22:36:52) running on X11: Ubuntu 10.04.4 LTS: Booting servers
<W>2013-05-20 19:50:40.317 1 => Server listening on [::]:64738
{% endcodeblock %}

The intent with this post was to introduce a project I've been working on named <a href="https://github.com/BrianMMcClain/nise-bosh-vagrant" target="_blank">nise-bosh-vagrant</a>, but this post is getting a bit long. Keep an eye out for another post very soon describing this project, what it does and how to do it.