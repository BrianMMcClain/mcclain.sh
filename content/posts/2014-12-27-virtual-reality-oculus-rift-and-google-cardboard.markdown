---
layout: post
title: "Virtual Reality - Oculus Rift and Google Cardboard"
date: 2014-12-27 11:09
comments: true
categories: 
- Unity
- Oculus
- Virtual Reality
- Google Cardboard
---

Yesterday, <a href="https://twitter.com/alexanderjklein" target="_blank">a good friend</a> and I took the day to sit down and really evaluate the Oculus Rift as a user and as a developer. Neither of us are exactly professional game developers by a long shot, but we've gotten to the point we can comfortably call ourselves "hobbyists". Also, early in the week I also received my <a href="https://www.google.com/get/cardboard/" target="_blank">Google Cardboard</a> and was pleasantly surprised at how well it worked, all things considered.

Using the Oculus Rift
---------------------

Initial setup of the Rift was not too terrible involved. A couple USB cables, a sync cable between the camera and the Oculus Rift, power and we were up and running. Windows 8.1 actually also picked up the Rift, but we elected to pull down the latest runtime (at the time, 0.4.4-beta). Past that, I jumped right into a few things I had pre-downloaded such as the <a href="https://share.oculus.com/app/oculus-tuscany-demo" target="_blank">"Oculus Tuscany Demo"</a> (<a href="https://www.youtube.com/watch?v=PKoSALEaV28" target="_blank"video</a>") in which you walk around a beautiful home and yard, the <a href="http://treyte.ch/oculus/" target="_blank">"Welcome to Oculus"</a> (<a href="https://www.youtube.com/watch?v=L0sCgavlns4" target="_blank">video</a>) experience which details the paradigm shift that current VR tech can offer and <a href="https://share.oculus.com/app/a-chair-in-a-room" target="_blank">"A Chair in a Room"</a> (<a href="https://www.youtube.com/watch?v=L9lNKX35avE" target="_blank">video</a>) which offers an immersive horror/scare experience.

The first thing that you notice with the Rift is that this isn't just a screen strapped to your face. Each eye is rendered separately, which gives a true feeling of 3D and allows you to properly analyze space and distance. The Tuscany demo has butterflies and plant seeds floating through the air, passing by your face and makes you feel like you need to brush them out of the way. This isn't the same 3D effect you get with passive glasses at the movie theater, objects have real depth to them.

Past that, what amazed me was the head tracking. I've read that the head tracking in the DK2 was good, but especially in the tech demos, it was near perfect. I'd be standing at a railing and lean forward, looking down below me. Part of the "Welcome to Oculus" experience, you're placed in a movie theater while clips from popular films play, and I was able to lean back behind me and look behind my chair. It wasn't just guessing, it was actually translating every movement of my head into the virtual space. Turning, leaning and tilting my head all translated perfectly (for most tests), which has a huge impact on immersion.

We proceeded to try out some full games/simulations with the Oculus, including:

- <a href="http://www.iracing.com/" target="_blank">iRacing</a> - One of the closest real-to-life racing simulators that's commercially available. I was racing a Mazda MX-5 and a prototype Ford card on the Laguna Seca, looking around in the car, reading the speedometer and tachometer. Combined with a force-feed back racing wheel and pedals, this was the one we kept coming back to.
- <a href="http://store.steampowered.com/app/227300/" target="_blank">Euro Truck Simulator 2</a> - A...truck driving simulator. Not exactly the most fun game we own, but strap on the Rift, using the wheel and pedals and loading up some of our favorite tracks, it was great to be able to look around the truck cabin, actually turn our heads to look at the mirrors as we backed the trailer up to the loading dock and eventually jackknife the thing.
- <a href="http://store.steampowered.com/app/220/" target="_blank">Half-Life 2</a> - This, to me, was the most surreal experience. Sure, the game is 10 years old and Oculus support is in beta, but I'm not alone in having this game on my Top 5 Games of All Time list. I've played through the game countless times but standing in front of the <a href="http://hl2.wikia.com/wiki/Metro_Police" target="_blank">Metro Police</a> as he knocked a soda can to the ground and forced me to pick it up, it was the closest I've felt to actually being in the shoes of <a href="http://en.wikipedia.org/wiki/Gordon_Freeman" target="_blank">Gordon Freeman</a>, shoes I've played in countless hours since the late 90s.

Among a few others. Each one offering an amazing, immersive (there's that word again) experience. We couldn't stop trying new games and tech demos, and every new one we tried had some new cool feature or detail that outdid the last.

Developing for the Oculus Rift
------------------------------

We spent nearly the entire day playing with the Oculus that we nearly forgot the other major plan for the day, which was to actually <i>make</i> something for it. We were hoping to have a solid plan on what that thing was that we wanted to make, but by the time we loaded up Unity to begin developing, we had no idea what it was that we could build in a night that would leverage everything the Oculus had to offer as a true VR experience. So we did what so many others before us did, copied whatever it was that people liked and remade it. The result?

<center>{% img /images/oculus-unity/home-rendered.png 500 600 %}</center>

A room with a comfortable couch and a massively oversized TV. We did not make the models or textures ourselves, as we were on a tight schedule, so we grabbed some pre-made furniture models and found some nice textures to go along with them. More than anything, I wanted to see how a scene I made in a very traditional way translated to the Oculus, and man did it not disappoint. We figured what better use of a virtual world with a giant TV to do something we can never do in real life...

<center>{% img /images/oculus-unity/home-twd.png 500 600 %}</center>

...we watched The Walking Dead.

But this wasn't about what the TV played, it was how things translated from our traditional development automatically over to the Oculus. As we sat on the couch, we looked around the room, down at the coffee table. We looked behind us and leaned over the couch, all these movements translating 1:1. This was enough to show us all of the possibilities of things we could make with the Oculus Rift.

Google Cardboard
-----------------

Google Cardboard, for those unfamiliar, is Google's solution to the currently relatively high cost of entry into the world of VR. Currently, the Oculus Rift is $350 for just the development kit, it is not a commercial-grade product. On the other hand, Google Cardboard and it's third-party brothers and sisters can be had for the price of a few cups of coffee. Cardboard is literally that, a piece of cardboard (and a couple lenses, some tape and a magnet). The trick is, however, that apps are rendered in a split view (much like the Oculus), and when your phone is placed into the Cardboard, the lenses distort the two separate, flat images into a single 3D view. There are still plenty of issues, including:

- Extreme "screen door effect" - As the resolution is so (relatively) low and the screen is so close to your face, you can make out the individual pixels, which makes it look like you are looking through a screen door.
- No head tracing - Which was one of the great parts of the Oculus. You can turn and tilt your head and everything translates fine, but there is no leaning
- Lack of input - The magnet acts as an input device with Google Cardboard, and translates to essentially a single tap on the screen. Some versions of Cardboard actually do exactly that, use a conductive material to tap the screen. The Oculus on the other hand has a wide array of input devices inherently available, as it's meant to be used with a computer.
- Apps are extremely taxing on the device - The Nexus 5 has pretty terrible battery life to begin with, but a short 10-15 demo of one or two Cardboard apps drains about 25% of my battery and the device gets extremely warm

However, for being less than 1/10th the price of an Oculus Rift, it is very impressive in it's own right. You still get the 3D feel of space and distance, and the freedom of mobility gives you some interesting options as far as games go.

<center>{% img /images/google-cardboard/dodocase.jpg 500 600 'I opted for the third-party Dodo Case VR' %}</center>

Cardboard Integration with Unity
--------------------------------

As I don't currently own an Oculus Rift, I wanted to see how it was to develop for Cardboard, as Google provides a <a href="https://developers.google.com/cardboard/unity/reference" target="_blank">full Cardboard SDK for Unity</a> and as it turns out, it's just as easy to develop with Cardboard in mind as it is any other 3D game. There are certain considerations to take into account, such as how input changes and how you focus your core game mechanics, but I took the same scene I built for the Oculus, simply swapped out the prefab that Oculus provides for it's cameras with the one Google provides for Cardboard, and built to Android. I did have to remove the MovieTexture that was playing The Walking Dead, as Unity does not support MovieTextures on mobile devices, but other than that, it was a single-step process and my on-the-cheap VR goggles dropped me right back on that familiar couch.

<center>{% youtube yGNl8c5mXfM %}</center>

I also took the same FPS Demo that I've been working on, as detailed in the previous post, and did the same process of simply swapping the cameras. Lo and behold, we have mobile VR!

<center>{% img /images/google-cardboard/fps-demo-cardboard.png 500 600 %}</center>

<br/>

------

These past few days really gave me a feel for the place that VR holds, not just in gaming but in countless applications. This isn't the first swag at VR, far from it even. But this <i>is</i> the first implementation that makes me feel like it finally has value, rather than just some gimmick.