---
layout: post
title: "Home Automation - Endpoints"
date: 2013-02-09 10:03
comments: true
categories: 
- Home Automation 
- Prototypes
- Endpoints
- Arduino
---

One of the most important pieces in the Miles Platform, in my opinion, will be the endpoints. In the unofficial dictionary for Miles, we're defining endpoints as the entity that connects the automation platform with physical components. Consider the blog post on automating <a href="/blog/2013/01/31/home-automation-lights/" target="_blank">lights</a>, in that design, an endpoint would control the relay that switches the light on and off.

Endpoint-Arduino
----------------

For the first stab at defining an endpoint, we decided to look at the Arduino. To be specific, we're looking at an Arduino Uno with the Ethernet shield. Our goal is to define a core set of capabilities that an endpoint has that can operate over, at minimum, a REST API. From there, an endpoint could define additional capabilities to enhance the features that it offers. 

For this example, we'll take a look at <a href="https://github.com/MilesPlatform/endpoint-arduino/blob/937b877a935a44aa8ce344d286014bf62a172b9d/endpoint_arduino.ino" target="_blank">endpoint-arduino</a>, which currently supports the most basic of capabilities, writing to and reading from a pin. The REST API for these calls is defined as follows...

{% codeblock %}
HTTP GET    /pin/[PIN NUMBER]/mode/[input,output] -- Set pin mode
HTTP GET    /pin/[PIN NUMBER] -- Get pin state
HTTP POST   /pin/[PIN NUMBER] -- Set pin to HIGH
HTTP DELETE /pin/[PIN NUMBER] -- Set pin to LOW
{% endcodeblock %}

(Side-note, I'm still not happy with the pin mode call)

So, four basic calls. Set the pin mode, set the pin to HIGH, set it to LOW, and retrieve it's current state. All commands return JSON in the following format...

{% codeblock lang:javascript %}
{
    "category": "pin",
    "command": "value",
    "key": 5,
    "success": true,
    "value": 1
}
{% endcodeblock %}

So what does this returned JSON tell us? Let's annotate this a bit...

{% codeblock lang:javascript %}
{
    "category": "pin", (Call made to /pin)
    "command": "value", (Modified or retrieved value of pin)
    "key": 5, (Pin #5)
    "success": true, (The command that was requested completed successfully)
    "value": 1 (Pin #5's value is 1, true, or HIGH, whichever you perfer)
}
{% endcodeblock %}

While this definition is a work in progress, I think it's best if this returned set of data is consistent between both endpoints and their special capabilities.

Endpoint-specific Capabilities
------------------------------

In discussions with <a href="https://twitter.com/markkropf" target="_blank">Mark Kropf</a>, he brings up being able to use SPI. I also have an immediate use for the <a href="https://www.virtuabotix.com/?p=239" target="_blank">Virtuabotix DHT11 Temperature and Humidity Sensor</a> which, while it offers a very handy and easy to use library, would be difficult/impossible to operate by reading from and writing to individual pins over HTTP communication. This is our next step of development, where Mark has said he'll be looking at SPI, I'll be adding an interface to the DHT11.