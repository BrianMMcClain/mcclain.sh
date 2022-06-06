---
title: "Virtual Reality - Oculus Rift and Google Cardboard"
date: 2014-12-27
tags: 
- Unity
- Oculus
- Virtual Reality
- Google Cardboard
---

Yesterday, I took the day to sit down and really evaluate the Oculus Rift as a user and as a developer. Early in the week I also received my [Google Cardboard](https://www.google.com/get/cardboard) and was pleasantly surprised at how well it worked, all things considered.

Using the Oculus Rift
---------------------

Initial setup of the Rift was not too terrible involved. A couple USB cables, a sync cable between the camera and the Oculus Rift, power and I was up and running. Windows 8.1 actually also picked up the Rift, but I elected to pull down the latest runtime (at the time, 0.4.4-beta). Past that, I jumped right into a few things I had pre-downloaded such as the [Oculus Tuscany Demo](https://share.oculus.com/app/oculus-tuscany-demo) ([video](https://www.youtube.com/watch?v=PKoSALEaV28)) in which you walk around a beautiful home and yard, the [Welcome to Oculus](http://treyte.ch/oculus/) ([video](https://www.youtube.com/watch?v=L0sCgavlns4)) experience which details the paradigm shift that current VR tech can offer and [A Chair in a Room](https://share.oculus.com/app/a-chair-in-a-room) ([video](https://www.youtube.com/watch?v=L9lNKX35avE)) which offers an immersive horror/scare experience.

The first thing that you notice with the Rift is that this isn't just a screen strapped to your face. Each eye is rendered separately, which gives a true feeling of 3D and allows you to properly analyze space and distance. The Tuscany demo has butterflies and plant seeds floating through the air, passing by your face and makes you feel like you need to brush them out of the way. This isn't the same 3D effect you get with passive glasses at the movie theater, objects have real depth to them.

Past that, what amazed me was the head tracking. I've read that the head tracking in the DK2 was good, but especially in the tech demos, it was near perfect. I'd be standing at a railing and lean forward, looking down below me. Part of the "Welcome to Oculus" experience, you're placed in a movie theater while clips from popular films play, and I was able to lean back behind me and look behind my chair. It wasn't just guessing, it was actually translating every movement of my head into the virtual space. Turning, leaning and tilting my head all translated perfectly (for most tests), which has a huge impact on immersion.

I proceeded to try out some full games/simulations with the Oculus, including:

- [iRacing](http://www.iracing.com/) - One of the closest real-to-life racing simulators that's commercially available. I was racing a Mazda MX-5 and a prototype Ford card on the Laguna Seca, looking around in the car, reading the speedometer and tachometer. Combined with a force-feed back racing wheel and pedals, this was the one I kept coming back to.
- [Euro Truck Simulator 2](http://store.steampowered.com/app/227300) - A...truck driving simulator. Not exactly the most fun game I own, but strap on the Rift, using the wheel and pedals and loading up some of our favorite tracks, it was great to be able to look around the truck cabin, actually turn my heads to look at the mirrors as I backed the trailer up to the loading dock and eventually jackknife the thing.
- [Half-Life 2](http://store.steampowered.com/app/220) - This, to me, was the most surreal experience. Sure, the game is 10 years old and Oculus support is in beta, but I'm not alone in having this game on my Top Games of All Time list. I've played through the game countless times but standing in front of the [Metro Police](http://hl2.wikia.com/wiki/Metro_Police) as he knocked a soda can to the ground and forced me to pick it up, it was the closest I've felt to actually being in the shoes of [Gordon Freeman](http://en.wikipedia.org/wiki/Gordon_Freeman), shoes I've played in countless hours since the late 90s.

Among a few others. Each one offering an amazing, immersive (there's that word again) experience. I couldn't stop trying new games and tech demos, and every new one I tried had some new cool feature or detail that outdid the last.

Developing for the Oculus Rift
------------------------------

I spent nearly the entire day playing with the Oculus that I nearly forgot the other major plan for the day, which was to actually _make_ something for it. I was hoping to have a solid plan on what that thing was that I wanted to make, but by the time I loaded up Unity to begin developing, I had no idea what it was that I could build in a night that would leverage everything the Oculus had to offer as a true VR experience. So I did what so many others before us did, copied whatever it was that people liked and remade it. The result?

![](/images/oculus-unity/home-rendered.png)

A room with a comfortable couch and a massively oversized TV. I didn't make the models or textures myself, as I was on a tight schedule, so I grabbed some pre-made furniture models and found some nice textures to go along with them. More than anything, I wanted to see how a scene I made in a very traditional way translated to the Oculus, and it did not disappoint. I figured what better use of a virtual world with a giant TV to do something I can never do in real life...

![](/images/oculus-unity/home-twd.png)

...I watched The Walking Dead.

But this wasn't about what the TV played, it was how things translated from our traditional development automatically over to the Oculus. As I sat on the couch, I looked around the room, down at the coffee table. I looked behind and leaned over the couch, all these movements translating 1:1. This was enough to show me all of the possibilities of things I could make with the Oculus Rift.

Google Cardboard
-----------------

Google Cardboard, for those unfamiliar, is Google's solution to the currently relatively high cost of entry into the world of VR. Currently, the Oculus Rift is $350 for just the development kit, it is not a commercial-grade product. On the other hand, Google Cardboard and it's third-party brothers and sisters can be had for the price of a few cups of coffee. Cardboard is literally that, a piece of cardboard (and a couple lenses, some tape and a magnet). The trick is, however, that apps are rendered in a split view (much like the Oculus), and when your phone is placed into the Cardboard, the lenses distort the two separate, flat images into a single 3D view. There are still plenty of issues, including:

- Extreme "screen door effect" - As the resolution is so (relatively) low and the screen is so close to your face, you can make out the individual pixels, which makes it look like you are looking through a screen door.
- No head tracing - Which was one of the great parts of the Oculus. You can turn and tilt your head and everything translates fine, but there is no leaning
- Lack of input - The magnet acts as an input device with Google Cardboard, and translates to essentially a single tap on the screen. Some versions of Cardboard actually do exactly that, use a conductive material to tap the screen. The Oculus on the other hand has a wide array of input devices inherently available, as it's meant to be used with a computer.
- Apps are extremely taxing on the device - The Nexus 5 has pretty terrible battery life to begin with, but a short 10-15 demo of one or two Cardboard apps drains about 25% of my battery and the device gets extremely warm

However, for being less than 1/10th the price of an Oculus Rift, it is very impressive in it's own right. You still get the 3D feel of space and distance, and the freedom of mobility gives you some interesting options as far as games go.

![I opted for the third-party Dodo Case VR](/images/google-cardboard/dodocase.jpg)

Cardboard Integration with Unity
--------------------------------

As I don't currently own an Oculus Rift, I wanted to see how it was to develop for Cardboard, as Google provides a [full Cardboard SDK for Unity](https://developers.google.com/cardboard/unity/reference) and as it turns out, it's just as easy to develop with Cardboard in mind as it is any other 3D game. There are certain considerations to take into account, such as how input changes and how you focus your core game mechanics, but I took the same scene I built for the Oculus, simply swapped out the prefab that Oculus provides for it's cameras with the one Google provides for Cardboard, and built to Android. I did have to remove the MovieTexture that was playing The Walking Dead, as Unity does not support MovieTextures on mobile devices, but other than that, it was a single-step process and my on-the-cheap VR goggles dropped me right back on that familiar couch.

{{< youtube yGNl8c5mXfM >}}

I also took the same FPS Demo that I've been working on, as detailed in the previous post, and did the same process of simply swapping the cameras. Lo and behold, we have mobile VR!

![](/images/google-cardboard/fps-demo-cardboard.png)

Final Thoughts
---

These past few days really gave me a feel for the place that VR holds, not just in gaming but in countless applications. This isn't the first swing at VR, far from it even. But this _is_ the first implementation that makes me feel like it finally has value, rather than just some gimmick.