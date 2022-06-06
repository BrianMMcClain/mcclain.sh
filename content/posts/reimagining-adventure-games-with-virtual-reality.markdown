---
title: "Reimagining Adventure Games with Virtual Reality"
date: 2015-01-07
tags: 
- Unity 
- Oculus
- Google Cardboard
- Virtual Reality
---

It's no secret that the [King's Quest series](https://en.wikipedia.org/wiki/King%27s_Quest) from [Sierra Entertainment](https://en.wikipedia.org/wiki/Sierra_Entertainment) is by far my most treasured video game series, with [King's Quest VI](http://en.wikipedia.org/wiki/King%27s_Quest_VI) holding the spot of my most favorite game ever. I've always had a soft spot for classic point-and-click adventure games, and certainly have noticed their absences in modern day gaming. I thought we might see them reemerge when the era of mobile gaming was just getting big, but there's no real noticeable titles that have come from that. I couldn't help question why that might be, and Ken Williams (Part of the husband-wife duo along with Roberta Williams, the creators of the King's Quest series among other classics) makes a great point in a [recent interview with Game Informer](http://www.gameinformer.com/b/features/archive/2015/01/02/ken-williams-interview-kings-quest-sierra-game-informer.aspx):


> **Game Informer**: Point-and-click adventures may not be as popular as they once were, but they were the top-tier games in the '80s and '90s. What about the genre do you think audiences that made it so popular for so long?
> 
> **Ken**: Personally, I never liked being pigeon-holed as “point and click”. I like to think of Sierra’s products as interactive stories, and point/click was nothing more than the best we could do at the time to influence the story. The idea was to make you feel a part of the story, and neither text parsing or point/click were perfect answers. A perfect answer would probably be 3-d glasses and motion sensors in gloves. Then you are talking! And, that’s the right experience. It’s like a good book or a good movie. The goal is to immerse the audience in the story. A mouse or a keyboard pulls the player out of the game. I don’t know the magic solution but know that saying things like this is a “touch-game” or a “click-game” or a “parser-based-game” are all dead-ends. They lock in a point in time and miss the fact that interactive technologies are advancing faster than games are being built. The right answer is to say, “what new technologies will be around two years from now when this game releases, and how do we use it to immerse the player in a cool new universe?” Saying, “Point/Click games sold 3 million copies last year, and the market is growing 5 percent a year, so next year there will be 3.15 million point/click games sold” – that’s a sucker trap. Sure death.


tl;dr: Point-and-click was simply the best option at the time, but was never optimal. I found this response particularly interesting as I was already contemplating how VR could change adventure games prior to this interview coming out, and Ken specifically calls out "3-d glasses". The motion-sensing gloves, however, wasn't exactly the same route I was going down.

Head Gestures
-------------

There's generally a small set of actions you can do in adventure games (or at least King's Quest VI, which I'm using as a model). Touch, Talk, Walk, Use, etc. Dialog is generally predetermined, and generally has no real input from the user (except for cases where the player uses an item on the person they are speaking with).

But that's the old-school way, isn't it?

I started pondering, if you move from point-and-click, what becomes _more_ important as a game mechanic? It's certainly not outside the realm of sanity to think that massively overhauling the input methods drastically changes how the game is played. I totally agree with Ken that something like motion-sensing gloves would be an ideal solution to interacting with the environment and managing and inventory system, where you could rummage through the goodies you've collected via some world-space menu, but what about that predetermined dialog? Parsed-based games offered some (but limited) control over dialog, but mouse-based games such as KQ6 gave you no option to answer questions or express emotion. 

This is where I though things could go a new direction with VR. All of the current-day VR devices offer a common thing, head tracking. Not all offer depth tracking, but the Oculus Rift, Google Cardboard, etc all allow the user to turn their head up and down, as well as tilt their head. The first new game mechanic that came to mind was head gestures; nodding for yes, shaking for no, the ability to bashfully look down at ones feet in embarrassment or shyness. Head tracking allows for a new portrayal of emotions via body language, and in an era where companies like [Telltale Games](https://www.telltalegames.com/) develop games based entirely around the idea of your responses driving the plot of the game (ie. [The Walking Dead](http://en.wikipedia.org/wiki/The_Walking_Dead_%28video_game%29) and [The Wolf Among Us](http://en.wikipedia.org/wiki/The_Wolf_Among_Us)), offering a similar, more immersive experience to fans of the series doesn't sound like the craziest idea in the world.

Proof of Concept
----------------

I'm not the first to have this idea, however. You can see an open source implementation [here](https://github.com/KatsuomiK/RiftGesture), and a tech demo around this idea already exists under the title [Trial of the Rift Drifter](http://www.aldindynamics.com/trial-of-the-rift-drifter). However, I've never let the existence of something stop me from  redundantly building it myself to learn.

{{< youtube RdDH__Ftb6E >}}

The result, as you can see above, is a brief offer of cold tea from Sir Squarington (give him a break, he's been stuck on an empty island in space for eternity with no teapot). You can accept his offer by nodding your head up and down, or deny it by shaking left and right. Additionally, Mr. S changes colors based on your head state:

**Blue**: Looking  
**Green**: Nodding ("Yes")  
**Red**: Shaking ("No")  

I don't believe that a VR-centric translation of the old-school point-and-click adventure games like KQ6 will ONLY take this as input. Ken is right, there's a secondary input method needed. A mouse and keyboard isn't it, but instead of motion sensing gloves, there's some promising tech such as the [Nimble VR](https://www.youtube.com/watch?v=v_U3BmDlmtc), a hand and finger tracker that was recently even [acquired by Oculus](https://www.oculus.com/blog/nimble-vr-13th-lab-and-chris-bregler-join-oculus/). 