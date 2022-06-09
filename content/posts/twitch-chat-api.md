---
title: "The Secret of the Twitch Chat API"
date: 2022-06-08
tags:
- twitch
- Go
description: Have you ever wondered what technology backs Twitch chat to support the volume and throughput of millions of concurrent chatters?
---

Have you ever been in a Twitch chat of someone with thousands, tens of thousands, or even hundreds of thousands of chatters? The endless firehose of memes and emotes seem to come so fast that it's almost impossible to read. Have you ever wondered what technology backs Twitch chat to support the volume and throughput of millions of concurrent chatters?

Spoilers: it's [IRC](https://dev.twitch.tv/docs/irc).

## IRC? Really?

Yeah you know, IRC. Created in the late 80s and popularized in the 90s, I'd use it in the early 2000's playing competitive Counter-Strike to post `5v5 | east | dust2 | cal-im | yours` over and over to find people to practice against. Granted (but just as important), IRC is a _protocol_ rather than a specific implementation, which leaves a lot of room for building efficiency. While Twitch's servers are based on [RFC1459](https://datatracker.ietf.org/doc/html/rfc1459.html), they only support a [subset of IRC messages](https://dev.twitch.tv/docs/irc#supported-irc-messages). In fact, to read and write chat message, we need just four commands:

1. `PASS` - The first half of the authentication to the chat server takes in an OAuth token (see below)
2. `NICK` - The second half of authentication takes in your matching username
3. `JOIN` - Joins a specific channel's chat
4. `PRIVMSG` - Send a message to the chat

Every command sent and received is terminated with a carriage return followed by a newline (`\r\n`)

## telnet - The Ultimate IRC Client

So theoretically, if Twitch chat is just a TCP socket listening for text (a gross oversimplification, but still), we could use, say, `telnet` to connect to it, right? Before we can start sending memes though, we have to get a login token. For an actual application, this means getting an authorization code through Twitch's OAuth servers, a process which may be a bit outside of the scope of this blog post. In short, you would:

1. Register your application in the [Twitch Developer Console](https://dev.twitch.tv/console/apps) to get a client ID and secret
2. Have your app setup an HTTP listener that Twitch will use for the callback
3. Redirect the user to `/oauth2/authorize`, providing the scope required for the token
4. Twitch will invoke your callback and provide an authorization code
5. Use that authorization code to make a REST request to Twitch to get a token

If you'd like, you can see this in an [application I wrote to try this myself](https://github.com/BrianMMcClain/twitch-buddy-go/blob/main/twitchbuddy/twitch.go#L40-L104). For our testing purposes though, we can use a [handy webapp to generate a token](https://twitchapps.com/tmi/). **NOTE:** This is not provided by Twitch, so use at your own discretion.

Once we have our token, let's connect to the Twitch chat server using telnet:

```bash
➜  ~ telnet irc.chat.twitch.tv 6667
Connected to irc.chat.twitch.tv.
Escape character is '^]'.
```

Let's then provide our token and username using the `PASS` and `NICK` commands respectively:

```bash
PASS oauth:REDACTED
NICK bmcclain
:tmi.twitch.tv 001 bmcclain :Welcome, GLHF!
:tmi.twitch.tv 002 bmcclain :Your host is tmi.twitch.tv
:tmi.twitch.tv 003 bmcclain :This server is rather new
:tmi.twitch.tv 004 bmcclain :-
:tmi.twitch.tv 375 bmcclain :-
:tmi.twitch.tv 372 bmcclain :You are in a maze of twisty passages, all alike.
:tmi.twitch.tv 376 bmcclain :>
```

Great! We're authenticated to the server, now let's go ahead and join a streams chat using the `JOIN` command:

```bash
JOIN #bmcclain
:bmcclain!bmcclain@bmcclain.tmi.twitch.tv JOIN #bmcclain
:bmcclain.tmi.twitch.tv 353 bmcclain = #bmcclain :bmcclain
:bmcclain.tmi.twitch.tv 366 bmcclain #bmcclain :End of /NAMES list
```

If I go into my Twitch chat and send a message, I'll see it show up in my terminal:

```bash
:bmcclain!bmcclain@bmcclain.tmi.twitch.tv PRIVMSG #bmcclain :hello from chat!
```

Finally, if I want to write back, I can use the `PRIVMSG` command to send a message

```bash
PRIVMSG #bmcclain :hello from telnet!
```

**NOTE:** Notice the space to the left of the colon between the channel name and the message you are sending. That space is required, however a space between the colon and the message is optional. Hey, I don't make the rules ¯\\_(ツ)_/¯

That's it! Telnet can actually act as a Twitch client! Well, sorta...

## Ping! Pong!

You see, Twitch doesn't want a bunch of connections hanging around with nobody on the other side. To periodically clean up connections, there's actually two more commands we need to know about: 

5. `PING` - Sent periodically from the Twitch servers
6. `PONG` - The expected response from the client, otherwise the connection will be terminated

These are Twitch's [keepalive messages](https://dev.twitch.tv/docs/irc#keepalive-messages). Twitch expects the text in the `PONG` response to match the text in the `PING` that you received. For example, if you receive:

```bash
PING :tmi.twitch.tv
```

You would then send back:

```bash
PONG :tmi.twitch.tv
```

## Is It That Simple?

Sorta :)

If you want to send and receive messages, that's all there is to it. However, if you're a Twitch viewer, you know that a lot more information is provided with each message. Badges, subscription status, mod status, etc. are all embedded in a single message. By default, only the username and message are provided for each chat message. You can however [request that Twitch send additional information](https://dev.twitch.tv/docs/irc/capabilities#requesting-twitch-specific-capabilities) with each message with the `CAP REQ` command:

```bash
CAP REQ :twitch.tv/membership twitch.tv/tags twitch.tv/commands
:tmi.twitch.tv CAP * ACK :twitch.tv/membership twitch.tv/tags twitch.tv/commands
```

This command enables all the additional Twitch-specific capabilities, but the one we're interested in is `twitch.tv/tags`. This adds additional tags to each message, which makes them look like this:

```bash
@badge-info=;badges=broadcaster/1;color=#FF7F50;display-name=bmcclain;emotes=;first-msg=0;flags=;id=5f1379da-433c-46db-be46-1d3cabd62ced;mod=0;room-id=50530155;subscriber=0;tmi-sent-ts=1654720885832;turbo=0;user-type= :bmcclain!bmcclain@bmcclain.tmi.twitch.tv PRIVMSG #bmcclain :hello with tags!
```

Alright, wow, that's a lot more information than we had before. Looking at it though, you can see that it's a semicolon-delimited list of key/value pairs, if we split those out to something more readable, we can see what we're working with:

```bash
@badge-info=
badges=broadcaster/1
color=#FF7F50
display-name=bmcclain
emotes=;first-msg=0
flags=
id=5f1379da-433c-46db-be46-1d3cabd62ced
mod=0
room-id=50530155
subscriber=0
tmi-sent-ts=1654720885832
turbo=0
user-type= 

:bmcclain!bmcclain@bmcclain.tmi.twitch.tv PRIVMSG #bmcclain :hello with tags!
```

Much more readable! We can see some interesting information right off of the bat: I'm the channel broadcaster (ie. the streamer), I'm not a subscriber nor do I have Twitch Turbo, there's a `display-name` value to get more info on how my name is displayed in chat, the color of my name, the message id, and more. If I were a subscriber, there would be another entry under the `badges` key that would look something like `subscriber/5` to denote that the chatter is a 5-month subscriber.

## Anything Else?

That's more or less it. There are some other [Twitch-specific IRC messages](https://dev.twitch.tv/docs/irc#supported-irc-messages) to look into if you decide to create a full-fledge chat client, but the above will get you up and running at least! If you're interested in some more ramblings on creating Twitch chat bots, check out the episode of Tanzu Tuesdays that I was one where I walk through all of this in the context of Spring Boot and Project Reactor, it was a ton of fun!

You can also see all of this in a fun little side project I've been working on to [implement this in Go](https://github.com/BrianMMcClain/twitch-buddy-go) to build a Twitch chat client. I apologize in advance for the code :)

{{< youtube jfIIOacAI50 >}}
