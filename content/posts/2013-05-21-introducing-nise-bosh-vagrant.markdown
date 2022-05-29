---
layout: post
title: "Introducing nise-bosh-vagrant"
date: 2013-05-21 09:35
comments: true
categories: 
- BOSH
- nise-bosh
- nise-bosh-vagrant
- vagrant
---

I'll admit, there was another reason I got excited about <a href="https://github.com/nttlabs/nise_bosh" target="_blank">nise_bosh</a>. Not only did it give me the oppertunity to set up Cloud Foundry v2 with ease, a first for me without access to a full BOSH environment that didn't involve me paying out of pocket, but I also saw it as my oppertunity to get back into developing BOSH releases. This meant I needed a quick way to iterate on BOSH releases and test them.

Enter: <a href="https://github.com/BrianMMcClain/nise-bosh-vagrant" target="_blank">nise-bosh-vagrant</a>

nise-bosh-vagrant is a quick project I started last week to help orchestrate this workflow so that I could leverage nise-bosh, but quickly standup and tear down Vagrant VMs as well as install BOSH releases in them. The goal was to keep the workflow simple, and reduce the time from downloading a BOSH release to having it up and running.

So let's see how to use it. I've distributed this as a ruby gem for ease of use, so installation is simply...

{% codeblock %}
$ gem install nise-bosh-vagrant
{% endcodeblock %}

Let's take a look at the possible arguments and flags...

{% codeblock %}
$ nise-bosh-vagrant -h
Based on nise-bosh from NTT Labs and Vagrant from HashiCorp

Requires Vagrant >= 1.2

Usage:
	   nise-bosh-vagrant [options] <BOSH Release>

Options:
  --manifest, -m <s>:   Path to manifest file
	  --nise, -n <s>:   Path to nise-bosh if you don't wish to pull HEAD of master from GitHub
	   --install, -i:   Run install script after preparing the VM
		 --start, -s:   Start all jobs after installing them (implies --install)
	   --version, -v:   Print version and exit
		  --help, -h:   Show this message
{% endcodeblock %}


There's only two required arguments: the path to the BOSH release and the path to the manifest file. Let's use the same release as we did when I wrote about nise-bosh, the <a href="https://github.com/BrianMMcClain/mumble-release" target="_blank">mumble-release</a>. We'll assume the release is at /home/brian/mumble-release and we've already ran `bosh create release`. We're also going to add two flags to help things out, `--install` and `--start`. This will automatically install the BOSH release after the machine has been prepared, and then start all the jobs in the release in the order that they're described in the manifest file.

{% codeblock %}
$ nise-bosh-vagrant /home/brian/mumble-release --manifest /home/brian/mumble-release/example/micro.yml --install --start

Job list: ["mumble"]
---> Starting Vagrant VM
Bringing machine 'default' up with 'virtualbox' provider...
[default] Importing base box 'lucid64'...
[...output removed for brevity...]
---> Preparing Vagrant VM
[...output removed for brevity...]
---> Installing release
The following templates and packages for job mumble will be installed.
	# mumble
		* mumble
#[18377] INFO: Resolving package dependencies...
#[18377] INFO: Installing the following packages:
#[18377] INFO:  * mumble
#[18377] INFO: Installing package mumble
#[18377] INFO: Running the packaging script for mumble
Done!
---> Starting release
monit: generated unique Monit id 1c60ef9e2f838770455b5705b69bc042 and stored to '/root/.monit.id'
'mumble' start: /var/vcap/jobs/mumble/bin/mumble_ctl
{% endcodeblock %}

This takes care of everything, beginning to end, that I covered in my <a href="http://catdevrandom.me/blog/2013/05/20/nise-bosh-a-new-way-to-bosh/" target="_blank">previous blog post</a>.

This also puts a few helpful scripts in place within the Vagrant VM:

1. `/home/vagrant/install_release.sh` -- Runs the nise-bosh commands to install all jobs described in the manifest file
2. `/home/vagrant/start.sh` -- Starts all jobs in the BOSH release
3. `/home/vagrant/stop.sh` -- Stops all jobs in the BOSH release

If you want to SSH into the Vagrant VM, the Vagrantfile is placed in the release directory, so in this example, it would be at /home/brian/mumble-release/Vagrantfile. There are <a href="https://github.com/BrianMMcClain/nise-bosh-vagrant/issues/3" target="_blank">plans</a> for a `nise-bosh-vagrant ssh` command.

This project is, admittedly, a work in progress. It works, however every time it stands up a VM, it uses a fresh Ubuntu image and runs the prep scripts, which takes a bit of time. However, there are <a href="https://github.com/BrianMMcClain/nise-bosh-vagrant/issues/5" target="_blank">plans</a> to create a Vagrant box with these preparations already in place. As of writing this, the current version of nise-bosh-vagrant is 0.2, but I'm hoping to continue to improve this, testing it by developing new BOSH releases.

So kick the tires! Break it, figure out what doesn't work and create an issue in GitHub!