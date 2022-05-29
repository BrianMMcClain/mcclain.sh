---
layout: post
title: "Spotify and Ruby - Using the Hallon Gem"
date: 2013-05-08 14:02
comments: true
categories: 
- Ruby
- Spotify
- Code
---

While still related to the <a href="https://github.com/milesplatform" target="_blank">Miles Platform</a>, I wanted to take a break from the home automation topics to do a quick review of an interesting Ruby gem I found called <a href="https://github.com/Burgestrand/Hallon" target="_blank">Hallon</a>.

For all my music needs, I would venture a guess that ~95% of my music listening is Spotify. While I work, in the car, around the house, it's all Spotify. When I looked at integrating music services with the Miles Platform, I was quick to start looking around for Ruby Spotify libraries. Some better than others, I ended up with what seems to be the de facto Ruby gem. Hallon is a very easy to use gem that offers a ton of flexibility and has great examples to get started. In fact, the <a href="https://github.com/MilesPlatform/audio-service" target="_blank">audio-service</a> in the Miles Platform already has Spotify integration.

I wanted to run through a quick example of logging in, searching for a song, and playing it back. What better than Daft Punk's latest release, <a href="http://open.spotify.com/track/2Foc5Q5nqNiosCNqttzHof" target="_blank">Get Lucky</a>? 

So first, let's do some prep work. The Hallon gem (or more accurately, Spotify’s APIs) requires you to provide three credentials: your username, your password, and an API key. API keys are binary files generated <a href="https://developer.spotify.com/technologies/libspotify/keys/" target="_blank">here</a>. As I like to do with all projects, I'll go ahead and write up a quick Gemfile...

{% codeblock Gemfile %}
source 'http://rubygems.org'

gem 'hallon'
gem 'hallon-openal'
{% endcodeblock %}

Yeah yeah, I know, versions. Anyways, these two gems do two very different things. The hallon gem provides the wrapper around libspotify, and is what interacts with the Spotify API, while <a href="https://github.com/Burgestrand/hallon-openal" target="_blank">hallon-openal</a> is the audio driver for streaming music from Spotify. 

Now on to the code. Let's start with logging in...

{% codeblock hallon_example.rb lang:ruby %}
require 'hallon'
session = Hallon::Session.initialize IO.read('./spotify_appkey.key')
session.login!('johndoe', 'superpassword')
{% endcodeblock %}

Super simple, just the way I like it. Point the Hallon::Session object to where you downloaded you API key and give it your username and password. 

Next up is actually finding the song which, as you would expect, is also simple...

{% codeblock hallon_example.rb lang:ruby %}
search = Hallon::Search.new("Daft Punk Get Lucky")
search.load
tracks = search.tracks[0...5].map(&:load)

puts "Top 5 Results"
tracks.each do |track|
	puts "#{track.artist.name} - #{track.name}"
end
{% endcodeblock %}


Essentially what we're doing here is creating a Search object with the query of "Daft Punk Get Lucky" and telling Hallon to perform the search. Hallon returns an array of Track objects that are just bare-bones objects, we have reference IDs to Spotifty objects, but that's it, so we iterate over the first five results and load the entire object from Spotify. Now let's go ahead and run this file just to see what we find so far...

```
➜  bundle exec ruby hallon_example.rb
Top 5 Results
Daft Punk - Get Lucky - Radio Edit
Pure Backing Trax - Get Lucky (Karaoke Version) - Originally Performed by Daft Punk
Face To Face - Get Lucky
Ameritz - Karaoke - Get Lucky (In the Style of Daft Punk and Pharrell Williams) [Karaoke Version]
Ameritz Top Tracks - Get Lucky (In the Style of Daft Punk and Pharrell Williams) [Karaoke Version]
```

Some interesting results, but that first one is the one we're looking for. Now that just leaves us with setting up the player so we can crank up the tunes and get the party started. Like the rest of the gem, doing this is just as easy...

{% codeblock hallon_example.rb lang:ruby %}
require 'hallon/openal'

player = Hallon::Player.new(Hallon::OpenAL)
player.play!(tracks.first)
{% endcodeblock %}

It's as easy as that. Create an object for the player, passing it Hallon::OpenAL, and then tell it to play a track object. You can see the whole thing put together <a href="https://gist.github.com/BrianMMcClain/5545400" target="_blank">here</a>.


Notes
-------

1. I had an issue (and vented about it on twitter) where the script was getting hung up logging in. Hallon creates a folder named "tmp" in the directory where your script is, and I had to remove this directory to be able to logged in. I have no explanation, only a possible solution.
2. You may notice when I played the track, I called `play!`. `play` also exists, but is non-blocking.
3. The rdoc for Hallon is insanely helpful. Read it, even if you're not stuck. There's some hidden gems of features in this project (ie. volume normalization).