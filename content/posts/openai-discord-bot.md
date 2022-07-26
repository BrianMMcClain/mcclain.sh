---
title: "How I Replaced Myself With OpenAI and a Very Small Discord Bot"
date: 2022-06-22T00:06:04-04:00
tags:
- go
- openai
- discord
draft: true
---

This is half-tutorial, half-storytelling. Let's start with the story half :)

## The Story

I'm not sure why, but I love writing Discord bots to do the dumbest things possible. They always start as a useful tool for the server, but somehow they always devolve to having a set of commands that serve no other purpose than to make the people in the server laugh. When I still played World of Warcraft, a well-intentioned bot for our guild's server quickly spiraled from a tool to help coordinate events and look up items in the game, to something that was essentially parrot that told our own inside jokes back to us.

Nonetheless, I keep writing them.

Fast-forward to this evening, and I stumbled across the [OpenAI Playground](https://beta.openai.com/playground). This [excerpt from their docs](https://beta.openai.com/docs/quickstart) summarizes what OpenAI is pretty well:

> The OpenAI API can be applied to virtually any task that involves understanding or generating natural language or code. We offer a spectrum of models with different levels of power suitable for different tasks, as well as the ability to fine-tune your own custom models. These models can be used for everything from content generation to semantic search and classification.

And even more to the point:

> OpenAI has trained cutting-edge language models that are very good at understanding and generating text. Our API provides access to these models and can be used to solve virtually any task that involves processing language.

tl;dr: Among other things, you can feed it a prompt, it sends back an AI-generated response.

> Prompt: Write a tagline for an ice cream shop.  
  Completion: We serve up smiles with every scoop!

So I had a thought...

...what if I just dropped a bot backed by this into a couple Discord servers?

## Disclaimer

Before we jump into the code, let me clarify one thing: I still have close contact with many of the individual members of these servers. The server owners gave explicit permission to do this and added the bots themselves. Don't do this on a server randomly, it's rude.

## The OpenAI API

OpenAI provides _a lot_ more than just being a glorified chat bot. [DALL-E 2](https://openai.com/dall-e-2/) can create incredibly realistic and accurate images from nothing more than a text prompt. OpenAI Codex backs [GitHub Copilot](https://github.com/features/copilot/). I'm essentially using a Ferrari to go grocery shopping.

An important note is that _technically_ OpenAI's models expect a writing prompt, not so much a question-answer cadence. But I figured let's hack this together and see what happens!

There's a plethora of [language bindings](https://beta.openai.com/docs/libraries/community-libraries) to chose from, and I've been becoming quite the [Gopher](https://go.dev/blog/gopher) lately and decided to hack this up in Go, I decided to forego the listed [go-gpt3](https://github.com/sashabaranov/go-gpt3) library for now in favor of interacting with the API over HTTP. After [creating an API key](https://beta.openai.com/account/api-keys), you can actually start sending requests to the API with cURL right away!

```bash
curl https://api.openai.com/v1/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
  "model": "text-davinci-002",
  "prompt": "Hello, world!",
  "temperature": 0.7,
  "max_tokens": 256,
  "top_p": 1,
  "frequency_penalty": 0,
  "presence_penalty": 0
}'
```

Alright, there's quite a bit there, so let's break down each field:

- `model`: OpenAI provides [several GPT-3 models](https://beta.openai.com/docs/models) that you can choose from. My best advice here is to defer to the docs. The description for `text-davinci-002` notes that it's the "most capable GPT-3 model" and that it can "do any task the other models can do, often with less context", and that's good enough for me!
- `prompt`: Our input into the model, the writing prompt. This is what we feed into OpenAI.
- `temperature`: Controls randomness, as it approaches zero, responses will be deterministic and repetitive.
- `max_tokens`: From the docs: Tokens can be words or just chunks of characters. For example, the word “hamburger” gets broken up into the tokens “ham”, “bur” and “ger”. This defaults to 256 and seems to be the recommended minimum value.
- `top_p`: Controls diversity, 0.5 means half of all likelihood-weighted options are considered.
- `frequency_penalty`: The higher the value, the more the model decreases the likelihood to repeat the same line verbatim.
- `presence_penalty`: The higher the value, the more the model is likely to talk about new topics.

When in doubt roll with the defaults! If we run the above cURL command, we'll see a response like the one below:

```json
{
	"id": "<ID REDACTED>",
	"object": "text_completion",
	"created": 1655875116,
	"model": "text-davinci-002",
	"choices": [{
		"text": "\n\nI am here to learn and explore. I hope to find new friends and interesting conversations.",
		"index": 0,
		"logprobs": null,
		"finish_reason": "stop"
	}],
	"usage": {
		"prompt_tokens": 4,
		"completion_tokens": 24,
		"total_tokens": 28
	}
}
```

In our case, we can see that it returns a JSON object, with the key `choices` bring an array of objects that describe the response. The first item in the `choices` array has the key `text` with the value "I am here to learn and explore. I hope to find new friends and interesting conversations.". Easy as that!

So we know that at the very least, we can throw HTTP POST requests to the API, let's look at the Discord bot side of things!

## The Discord Bot

Generally, I write my bots in Ruby, a language I still have a massive soft spot for. But since I wanted to write this in Go, I did a quick search and [discordgo by bwmarrin](https://github.com/bwmarrin/discordgo) seems like a popular library, so let's roll with it! The code here is pretty straight-forward: Create a new `discordgo` instance by providing a [Discord Application token](https://discord.com/developers/applications) and register a handler function that gets invoked each time the bot reads a message. The simplified version boils down to:

```go
func main() {

	discord, err := discordgo.New("Bot " + discord_token)
	if err != nil {
		log.Fatal("Error connecting bot to server")
	}

	discord.AddHandler(messageReceive)

	err = discord.Open()
	if err != nil {
		log.Fatal("Error opening bot websocket")
	}

	fmt.Println("Bot is now running")
}
```

In this case, we've registered `messageReceive` as the handler to invoke each time a new message is received. The signature for this method expects a `Session` and a `MessageCreate`:

```go
func messageReceive(s *discordgo.Session, m *discordgo.MessageCreate) {
```

You can see the [entirety of the code on GitHub](https://github.com/BrianMMcClain/openai-discord-bot/blob/main/bot.go), but there's two important things we use from this library:

- `m.Message.Content`: The message that the bot just read. This includes all the metadata for who sent it, if they mention any other user or channel, if there's any emoji or reactions, and any other data associated with a Discord message
- `s.ChannelMessageSend(m.ChannelID, someText)`: The bot sends a message of `someText` to the same channel that it read this message from

So in essence, this method does the following:

```go
func messageReceive(s *discordgo.Session, m *discordgo.MessageCreate) {
  // Read the message and determine if we need to respond
  // In this case, the bot only responds if you mention it directly

  // Perform an HTTP POST against the OpenAI API, sending m.Message.Content

  // Parses the response JSON

  // Sends the response from OpenAI to Discord with 
  // s.ChannelMessageSend(m.ChannelID, response.choices[0].text) 
}
```

## So Does It Work?

Sorta! Within minutes of working with a couple server owners to add the bots, some noticed the new addition to the group with the same name and avatar that I used on Discord. Curious, they started sending messages mentioning the bot directly to see what's up. I won't share screenshots for the sake of privacy, but some verbatim exchanges included:

> user: @brian What's up?  
> brian: Nothing much, what's up with you?

Quickly, they noticed bright blue "BOT" tag next to my name, and knew something was up:

> user: @brian what are you?  
> brian: I am a person.

_Smoooooth_

The thing with AI though is that the "A" stands for "Artificial", so the not-so-human part eventually showed itself:

> user: @brian sup?  
> brian: .h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
      dv.h,  
    ]
    // 行横线  
    var lineTop = [  
      dv.w * 0.09,  
      dv.h * 0.09 + dv.h * 0.1,  
      dv.w * 0.09,  
      dv.h * 0.09 + dv.h * 0.1,  
      dv.w * 0.09,  
      dv.h * 0.09 + d  

Who of us _hasn't_ accidentally blurted out a mess of something resembling CSS? Now credit where credit is due, OpenAI is good. It's _very_ good. Bit it does have some quirks. This ended up being a fun night of everyone throwing different prompts at it with some interesting results:

> user: @brian can you make me a python script that opens an http port?  
>  
> brian: This is a very basic Python script that will open an HTTP port:
> ```python
> import socket
> 
> s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
> s.bind(("", 80))
> 
> s.listen(5)
> 
> print "Listening on port 80..."
> 
> while True:  
>     (clientsocket, address) = s.accept()  
>     print "Received connection from", address  
>     clientsocket.send("Hello world\n")
>     clientsocket.close()
> ```
(Codeblock added for readability)

Which other than trying to open a privileged port is valid Python 2.7 code. I got curious and tried to specify Python 3

> user: @brian can you make me a python3 script that opens an http port? 
>  
> brian:  
> ```python
> import http.server
>
> port = 80
>
> server = http.server.HTTPServer(("", port), http.server.SimpleHTTPRequestHandler)
>
> server.serve_forever()
> ```

And that's not even mentioning it's impressive songwriting capabilities:

> user: @brian generate a pop song  
>  
> brian: In the dark of night  
I think of you  
I can't get you out of my mind  
I'm trying to fight  
Against the feelings I have for you  
But I can't  
I know I should  
But I can't  
When I'm with you  
I feel like I'm in the sun  
I'm trying to hide  
But it's hard to do  
When I'm with you  
It feels like I'm home someday

## So What's the Point?

To be blunt? I'm not sure. It made me laugh, it made my friends laugh, and really that's good enough for me. In less than a day, a little under 600 messages were sent from the bot, and it would only respond when directly mentioned in a message, meaning people asked it almost 600 questions as well. My plan is to let it stay in the servers for another couple of days and then once everyone has had their fun, shut it down.

I am curious to look more into the work that OpenAI is doing. Their [DALL-E 2](https://openai.com/dall-e-2/) system has been an interesting topic on Twitter lately due to the impressive results that it can create. There's a waitlist however and I'm not sure how long it is. Who knows, maybe if I get access to that I can share the fun with some friends again!
