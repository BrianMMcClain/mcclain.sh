---
layout: post
title: "Home Automation - Lights"
date: 2013-01-31 17:22
comments: true
categories: 
- Home Automation 
- Prototypes
- Lights
---

For the first prototype, I looked at a fairly visual, useful and simple problem. I want to be able to control my house lights. In the end, I hope to control if they're on or off, brightness and possibly even color (This one might be a bit far off, still researching hardware). For starters, I figured I'd handle the simplest case: on or off.

Warning
-------
Let me preface this by saying that I am not classicaly educated in circuitry at all. I have been, however, doing my homework so I don't injure myself. If you decide to do this yourself, please, please PLEASE be aware of the dangers of working your homes electricty. If this is a standalone circuit to learn, as I did, keep things unplugged while you're hooking things up and ensure not to touch the live wire while interacting with it. If this is already a part of a light circuit and you're applying this to your home, flip the breaker for that circuit. I'm not responsible for your injuries, but I certainly don't want anyone to get hurt.

Prototype
--------

I knew I wanted to wire this up as if it were wired up with two three-way switches. This operates exactly the same way as if you had two light switches to control one light, except I've replaced one with a relay that will be operated by an Arduino. Here's a poorly drafted design of such a circuit

{% img /images/home_automation/02_lights/ha_lights_circuit_01.png %}

Again, not classically trained.

This is a fairly common setup in a lot of houses. As I mentioned, I've simply replaced one of the light switches with a relay. I've actually picked up a <a href="http://www.amazon.com/SainSmart-4-Channel-Relay-Module-Arduino/dp/B0057OC5O8/ref=sr_1_1?ie=UTF8&qid=1359685138&sr=8-1&keywords=arduino+relay" target="_blank">board with 4 relays</a> and it's been great for prototyping. The neutral line runs straight to the light, and the hot wire runs to the common on the first switch, the two travelers to the second switch, and from the common on the second switch to the light.

After that, it was a matter of writing some quick code for the Arduino, which can be found <a href="https://github.com/MilesPlatform/prototypes/blob/master/lights/relay_rest/relay_rest.ino" target="_blank">here</a>.

As described in the code, this provides a REST interface to each relay, where a POST turns the relay on, a DELETE turns the relay off, and a GET returns the state of the relay. All returned values are in JSON format, because I like to overdo things.

Conclusion
----------
While this won't be my last prototype for the house lights, this certainly opened my eyes of things to keep in mind as I implement this throughout my house. Discussions are underway on how to improve this, both from a feature standpoint and an efficiency standpoint, and the next step will be to control the dimming of the lights.