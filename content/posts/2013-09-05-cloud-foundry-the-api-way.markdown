---
layout: post
title: "Cloud Foundry the API Way"
date: 2013-09-05 00:05
comments: true
categories: 
- Cloud Foundry
- API
---

This is a topic I've seen come up a couple times in the last few weeks. It started with <a href="https://twitter.com/drnic" target="_blank">Dr. Nic Williams</a> when we were discussing <a href="https://github.com/cloudfoundry-community/share-my-cloudfoundry" target="_blank">share-my-cloudfoundry</a> when he wanted to provide compatibility with Cloud Foundry v1 and v2 in the same application. This situation came up again with a personal project that I will detail later.

It required a bit of <a href="https://groups.google.com/a/cloudfoundry.org/forum/?fromgroups#!topic/vcap-dev/5G3mWs2e0u4" target="_blank">discussion</a>, but I finally tracked down the answers. Although the <a href="https://github.com/cloudfoundry/cfoundry" target="_blank">cfoundry gem</a> states that it is compatible with Cloud Foundry v1 and v2, after some digging, it looks like it's only compatible with v2. To make things a bit more complicated, even though the old cfoundry library was moved to a separate repository, it retained the "cfoundry" gem name, meaning I could not include both gems in a single Gemfile.

Finally, Nic pointed out <a href="https://github.com/cloudfoundry-community/cloudfoundry-client" target="_blank">cloudfoundry-client</a> developed by <a href="https://twitter.com/ferdy" target="_blank">Ferran "ferdy" Rodenas</a>, another Cloud Foundry superstar. I did a bit of playing around and it seems to fit my needs for Cloud Foundry v1. Combined with the currently maintained cfoundry gem for v2 compatibility, we've found the solution to our problem.

cloudfoundry-client's tests are written just as I like to write my tests, so I was able to read through those to understand the usage of the gem. The cfoundry gem has great tests as well, but also has a piece in the <a href="http://docs.cloudfoundry.com/docs/using/managing-apps/libs/ruby-cfoundry.html" target="_blank">Cloud Foundry Docs</a>. Unfortunately, they don't seem to be 100% up to date. So, I've decided to provide the code I used to push an application to both Cloud Foundry v1 and v2, explaining it along the way.

Preparing the App
-----------------

In both Cloud Foundry v1 and v2, the vmc and cf CLI utilities create a zip file to upload to the environment. We need to handle this ourselves, which can be done with some simple code:

{% codeblock lang:ruby %}
require 'zip/zip'

Zip::ZipFile.open('app.zip', Zip::ZipFile::CREATE) do |zipfile|
  Dir.glob('./sinatra_app/*').each do |path|
  	name = path.sub("./sinatra_app/", "")
    zipfile.add(name, path)
  end
end
{% endcodeblock %}

There's some code here specific to me, but you can reference the <a href="http://rubygems.org/gems/zip" target="_blank">zip gem</a>. The important thing here is that the top level of the zip file is exactly as your current directory would be when pushing you application to Cloud Foundry. The other disclaimer is that this little chunk was modified from the CF Docs fairly quickly, so not guarantees this specific piece of code is production ready. 

The application itself doesn't particularly matter, but in my example code, I'll be pushing a Sinatra application. Here are the relevant pieces of code:

{% codeblock Gemfile lang:ruby %}
source "http://rubygems.org"

gem 'sinatra'
{% endcodeblock %}

{% codeblock config.ru %}
require './app'
run Sinatra::Application
{% endcodeblock %}

{% codeblock app.rb lang:ruby %}
require 'sinatra'

get '/' do
	"Hello World!"
end
{% endcodeblock %}

The config.ru file is only needed for CFv2, but this app will work on both CFv1 as well as v2. 

Pushing to Cloud Foundry v1
---------------------------

The code to push an application to CFv1 is actually very simple

{% codeblock lang:ruby %}
require "cloudfoundry"

# Target Cloud Foundry
cf_client = CloudFoundry::Client.new({:target_url => "http://api.some.cloud.foundry.me"})

# Log in
cf_client.login("someone@example.com", "myawesomepassword")

manifest = {
          :name => "testapp",
          :uris => ["testapp.some.cloud.foundry.me"],
          :instances => 1,
          :staging => {:model => "sinatra"},
          :resources => {:memory => 128},
        }

# Creating the application
cf_client.create_app("testapp", manifest)

# Upload the application
cf_client.upload_app("testapp", "./app.zip")

# Start the app
app_info = cf_client.app_info("testapp")
app_info[:state] = "STARTED"
cf_client.update_app("testapp", app_info)
{% endcodeblock %}

Most of this code is self-explanatory, except maybe the manifest hash. You'll notice some of these fields don't match up with what you may be used to in a manifest.yml file. This is the format that the Cloud Foundry API expects, but I think once you see an example, it becomes pretty easy to know how to modify this as needed. The rest of the calls are mostly one-liners, except for actually starting the app. This is achieved in the CF API by setting the applications state to "STARTED". Now that the cloudfoundry-client gem is a part of the cloudfoundry-community project, I may spend some time adding some helper methods to the API to ease some of these things.

Pushing to Cloud Foundry v2
---------------------------

Pushing an application to CFv2 is a bit more complicated, so we'll break this out into chunks of code instead of looking at it all at once. First, we want to log in and create the application

{% codeblock lang:ruby %}
require 'cfoundry'

endpoint = 'http://api.my.v2.cloud.foundry.me'
username = 'someuser@example.com'
password = 'myawesomepassword'

# Target CF
client = CFoundry::Client.get(endpoint)

# Log in
client.login({:username => username, :password => password})

# Hardcoded value, but in our example env, this is the space we want to use
space = client.spaces[1]

# Get a new app object
app = client.app

# Create a shell of an app
app.name = 'testapp'
app.total_instances = 1
app.memory = 512
app.space = space
app.create!
{% endcodeblock %}

The v2 gem doesn't take a hash like the v1 gem does, but rather treats the application as an object. So far we haven't done anything crazy, just simply target our CFv2 endpoint, logged in, and created a shell of an application. The next step is to create the route to map to our application:

{% codeblock lang:ruby %}
# Get a new route object
route = client.route

# In our example env, we only have one route, so we'll use that
route.domain = client.domains.first

# We want to assign the route to the same space we created our app in
route.space = space

# As with the v1 example, the host part of the URL will be 'testapp'
route.host = 'testapp'

# Create the route
route.create!
{% endcodeblock %}

So far, so good, but our app in CF isn't really an app yet, but all of the pieces are in place. We can now upload our application:

{% codeblock lang:ruby %}
app.upload("app.zip")
{% endcodeblock %}

Here we simply pass the path to the zip file of our application to the #upload method on the app object. And finally we need start the app:

{% codeblock lang:ruby %}
app.start!
{% endcodeblock %}

That's great and all, but what about all of that awesome information that CF spits out while staging and starting our application? Plus this is an async method, how can we get any idea on the progress of this? Well, the #start method actually can take in a block of code. Here's another example of how to start an app:

{% codeblock lang:ruby %}
app.start!do |url|
  begin
    offset = 0

    while true
      begin
        client.stream_url(url + "&tail&tail_offset=#{offset}") do |out|
          offset += out.size
          print out
        end
      rescue Timeout::Error
      end
    end

  rescue CFoundry::APIError
  end
end
{% endcodeblock %}

Now when we start our application, we'll see that same output that we get when using the cf CLI utility:

{% codeblock %}
-----> Downloaded app package (4.0K)
-----> Using Ruby version: ruby-1.9.3
-----> Installing dependencies using Bundler version 1.3.2
       Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin --deployment
       Fetching gem metadata from http://rubygems.org/..........
       Fetching gem metadata from http://rubygems.org/..
       Installing rack (1.5.2)
       Installing rack-protection (1.5.0)
       Installing tilt (1.4.1)
       Installing sinatra (1.4.3)
       Using bundler (1.3.2)
       Your bundle is complete! It was installed into ./vendor/bundle
       Cleaning up the bundler cache.
-----> WARNINGS:
       You have not declared a Ruby version in your Gemfile.
       To set your Ruby version add this line to your Gemfile:"
       ruby '1.9.3'"
       # See https://devcenter.heroku.com/articles/ruby-versions for more information."
-----> Uploading droplet (23M)
{% endcodeblock %}

You'll notice that CFv2 complains about not specifying a version of Ruby to use in our Gemfile. I've left that out because in CFv1, it actually errors out if you DO specify a version of Ruby to use.

Conclusion
----------

I'm not sure how many people will need CFv1 and CFv2 compatibility in their projects, but what we've seen is both APIs are very friendly to use, especially if you're familiar with the CF APIs. As I mentioned, cloudfoundry-client is now a part of the cloudfoundry-community organization, so if you feel like contributing to the v1 compatibility, you can find the repository on <a href="https://github.com/cloudfoundry-community/cloudfoundry-client" target="_blank">Github</a>.