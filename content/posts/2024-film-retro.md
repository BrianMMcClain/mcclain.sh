---
title: "My 2024 Film Retrospective"
date: 2025-01-01T00:00:00-05:00
description: Some thoughts on films I watched in 2024.
---

A couple years ago, I made a concentrated effort to rekindle my love for film. My 2022 goal was to watch 100 films I had never seen before, and it was a great way to get back to this interest while allowing me to explore films I probably wouldn't have seen otherwise.

This year, I wanted to look back at the films I watched in 2024 while I look forward to 2025.

## 2024 goals

For 2024, I didn't aim for a specific number of films. Rather I wanted to experience filmmakers from countries that I don't usually seek out. When I tried to put a metric behind this though, it gets a little blurry. 

Movies are a work of many hands. Take [Like Someone in Love (2012)](https://www.imdb.com/title/tt1843287/) for example. It was filmed in Japan by Japanese actors, directed by an Iranian director (the amazing Abbas Kiarostami), and is a French-Japanese co-production by mk2 and Eurospace. For many films, trying to attribute the work to any single country becomes reductive and impossible.

I decided to continue with my 2024 goal, just without measuring it very strictly.

## Overall statistics

All of this data was pulled from my [Letterboxd diary](https://letterboxd.com/brianmmcclain/films/diary/for/2024/), supplemented by the [TMDb API](https://developer.themoviedb.org/reference/intro/getting-started).

> A quick note about how I think about rating a film. I've rated every film on a scale of zero to ten. To me, the whole scale is fair game and a "5" is an average film -- I didn't love it, I didn't hate it.

**Films watched**: 175  
**Total runtime**: 327h 39m  
**Average rating**: 7.2  
**Rewatch count**: 6  

**First film of 2024**: [Synecdoche, New York (2008)](https://www.imdb.com/title/tt0383028/)  
**Last film of 2024**: [Nosferatu: A Symphony of Horror (1922)](https://www.imdb.com/title/tt0013442/)  
**Oldest film**: [Nosferatu: A Symphony of Horror (1922)](https://www.imdb.com/title/tt0013442/)  

I thought it was interesting that, on average, I rated the films I watched over a "7", which means I really enjoyed it! I think there are two contributing factors:

1. A lot of films I watched this year were explicit recommendations from sources I trust, which means they tend to be films that are generally well-received and in line with my interests.
2. I just really like watching movies. It puts me in a good mood and helps me relax. 

### Rating distribution

Below is the distribution of how I rated all of the films I watched in 2024.

{{< chart id="allRatings" title="Rating distribution of all watched films" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    datasets: [{
        label: '# of Films',
        data: [1,0,0,2,4,8,24,49,64,23,0],
        borderWidth: 1
    }]
 },
 options: {
    scales: {
        y: {
            beginAtZero: true
        }
    }
 }
};

{{</ chart >}}

|Rating|Count|
|------|-----|
|0|1|
|1|0|
|2|0|
|3|2|
|4|4|
|5|8|
|6|24|
|7|49|
|8|64|
|9|23|
|10|0|

One correction in this data is that a film marked as "watched" but not rated on Letterboxd shows as a "0" rating. The film in question, [New York Ninja (2021)](https://www.imdb.com/title/tt15358226/) is actually a very unique movie. It was filmed in 1984, but the distribution company went bankrupt before post-production. Years later, the raw film was rediscovered without audio or a script. [Vinegar Syndrome](https://vinegarsyndrome.com/) acquired this footage, edited it, dubbed the audio, and eventually released the film in 2021. It's hard to rate this film in the context of everything else I watched in 2024, so I decided not to include one.

### Films by genre

Below is a breakdown of films by genre. Films in [TMDB's](https://www.themoviedb.org/) database can have multiple tags, so the total count here doesn't match the total number of films I watched. 

{{< chart id="genre" title="Films by genre" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['Drama', 'Comedy', 'Thriller', 'Romance', 'Crime', 'Horror', 'Action', 'Science Fiction', 'Mystery', 'Adventure', 'Fantasy', 'Music', 'Animation', 'History', 'Family', 'War', 'Documentary'],
    datasets: [{
        label: '# of Films',
        data: [107,55,39,36,29,24,23,19,16,13,10,6,5,5,3,2,1],
        borderWidth: 1
    }]
 },
 options: {
    scales: {
        y: {
            beginAtZero: true
        }
    }
 }
};

{{</ chart >}}

|Genre|Count|Percent|
|-----|-----|-------|
|Drama|107|61.14%|
|Comedy|55|31.43%|
|Thriller|39|22.29%|
|Romance|36|20.57%|
|Crime|29|16.57%|
|Horror|24|13.71%|
|Action|23|13.14%|
|Science Fiction|19|10.86%|
|Mystery|16|9.14%|
|Adventure|13|7.43%|
|Fantasy|10|5.71%|
|Music|6|3.43%|
|History|5|2.86%|
|Animation|5|2.86%|
|Family|3|1.71%|
|War|2|1.14%|
|Documentary|1|0.57%|

While interesting, what throws this data off a bit is how many films include "Drama" as a genre, as it tends to be a catch-all classification. I have been wanting to watch more animated films though, so we can use this as a comparison at the end of 2025.

### Films by language

Below is a breakdown of films by primary spoken language. Each film is only counted once, even if multiple languages are listed.

{{< chart id="language" title="Films by language" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['English', 'Japanese', 'French', 'Korean', 'Italian', 'Chinese', 'German', 'Cantonese', 'Russian', 'Swedish', 'Irish', 'Finnish', 'Norwegian', 'Polish', 'Czech'],
    datasets: [{
        label: '# of Films',
        data: [108,31,11,6,3,3,3,2,2,1,1,1,1,1,1],
        borderWidth: 1
    }]
 },
 options: {
    scales: {
        y: {
            beginAtZero: true
        }
    }
 }
};

{{</ chart >}}

|Language|Count|Percent|
|--------|-----|-------|
|English|108|61.71%|
|Japanese|31|17.71%|
|French|11|6.29%|
|Korean|6|3.43%|
|Italian|3|1.71%|
|Chinese|3|1.71%|
|German|3|1.71%|
|Russian|2|1.14%|
|Cantonese|2|1.14%|
|Finnish|1|0.57%|
|Czech|1|0.57%|
|Swedish|1|0.57%|
|Polish|1|0.57%|
|Irish|1|0.57%|
|Norwegian|1|0.57%|

There's a lot of bias hiding in this data. This year I also started studying Japanese, which led me to watch a lot of Japanese films. Then, I found Japanese directors I really enjoyed, and ended up watching more of their work. 

### Films by decade

Below is a breakdown of films by the decade they released. 

{{< chart id="decade" title="Films by decade" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['1920', '1930', '1950', '1960', '1970', '1980', '1990', '2000', '2010', '2020'],
    datasets: [{
        label: '# of Films',
        data: [1,1,9,9,12,18,23,17,29,56],
        borderWidth: 1
    }]
 },
 options: {
    scales: {
        y: {
            beginAtZero: true
        }
    }
 }
};

{{</ chart >}}

|Decade|Count|Percent|
|------|-----|-------|
|1920|1|0.57%|
|1930|1|0.57%|
|1950|9|5.14%|
|1960|9|5.14%|
|1970|12|6.86%|
|1980|18|10.29%|
|1990|23|13.14%|
|2000|17|9.71%|
|2010|29|16.57%|
|2020|56|32.00%|

I've always felt like I don't explore films prior to the 1970s much, and the data backs this up. Of the 175 films I watched this year, only 20 were from the 1960s or earlier.

### Highest rated films (Rated 9/10):

While no film I watched this year quite hit a 10/10 for me (with some strong contenders I may revisit and bump up), there were so many amazing ones I was lucky enough to watch. Below are the films I watched in 2024 that I rated 9/10.

|Title|
|-----|
|Nosferatu|
|Roman Holiday|
|The 400 Blows|
|The Holdovers|
|Sunset Boulevard|
|Aftersun|
|Alien|
|Yi Yi|
|Your Name.|
|Tampopo|
|Cinema Paradiso|
|Dreams|
|High and Low|
|The Godfather Part II|
|Wings of Desire|
|Perfect Days|
|Come and See|
|Ikiru|
|Drive My Car|
|La Haine|
|Before Sunset|
|Rear Window|
|Godzilla|

## 2024 films

The definition of a "2024 film" isn't very cut and dry. Some of these released prior to 2024 (some as early as 2022), but only in festivals and didn't receive distribution until later. For this list, I'm going off of the US release dates.

|Title|Rating|
|-----|------|
|Anora|8|
|Conclave|8|
|La Chimera|8|
|Dune: Part Two|8|
|Dìdi (弟弟)|8|
|Hundreds of Beavers|8|
|Kneecap|8|
|Baby Assassins: Nice Days|7|
|Evil Does Not Exist|7|
|Hit Man|7|
|Love Lies Bleeding|7|
|The Substance|7|
|Alien: Romulus|6|
|Furiosa: A Mad Max Saga|6|
|Gladiator II|6|
|Monkey Man|6|
|Saturday Night|6|
|The 4:30 Movie|6|
|Twisters|6|
|Drive-Away Dolls|5|
|Fly Me to the Moon|5|
|Juror #2|5|
|Lisa Frankenstein|5|
|The Last Stop in Yuma County|5|
|Venom: The Last Dance|5|
|Megalopolis|4|
|Strange Darling|4|

There's some missing here that I haven't had a chance to catch before the end of the year, but plan to watch as soon as I can:

- [A Real Pain](https://www.imdb.com/title/tt21823606/)
- [The Brutalist](https://www.imdb.com/title/tt8999762/)
- [Nickel Boys](https://www.imdb.com/title/tt23055660/)
- [Nosferatu](https://www.imdb.com/title/tt5040012/)
- [Rebel Ridge](https://www.imdb.com/title/tt11301886/)
- [Red Rooms](https://www.imdb.com/title/tt22207786/)
- [Sing Sing](https://www.imdb.com/title/tt28479262/)

### 2024 rating distribution

Below is the distribution of how I rated the films released in 2024 that I watched.

{{< chart id="thisYearRating" title="2024 Rating Distribution" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    datasets: [{
        label: '# of Films',
        data: [0,0,0,0,2,6,7,4,6,0,0],
        borderWidth: 1
    }]
 },
 options: {
    scales: {
        y: {
            beginAtZero: true
        }
    }
 }
};

{{</ chart >}}

|Rating|Count|
|------|-----|
|0|0|
|1|0|
|2|0|
|3|0|
|4|2|
|5|6|
|6|7|
|7|4|
|8|6|
|9|0|
|10|0|

Overall, I enjoyed most of the 2024 films I watched. I thought a good handful were great, but none of them really crossed over into "amazing" territory for me. 

### 2024 highlights 

These are the films from this year that really stuck with me in one way or another.

- **[Dìdi](https://www.imdb.com/title/tt30319503/)**: I'm close to calling this my favorite of 2024 (assuming we're counting [Perfect Days](https://www.imdb.com/title/tt27503384/) as a 2023 film, and pending some really big titles I haven't seen yet). I'm such a sucker for films about growing up in the MySpace age. Having also been that kid that always had a camera in his hand, this one hit very close.

- **[Kneecap](https://www.imdb.com/title/tt27367464/)**: So so so much fun, I had a smile on my face the entire time. Some of the funniest writing of the year and I have a few new songs added to my music playlist as a bonus.

- **[Hundreds of Beavers](https://www.imdb.com/title/tt12818328/)**: I don't have much to say about this one that hasn't already been said, but this was such a unique film. Described as "live action Loony Toons", I think this one deserves the title of most inventive film of the year. I also thought the [behind the scenes](https://www.youtube.com/watch?v=rJpLav2ij5Y) gave some amazing detail on how they achieved the look and feel on such a limited budget.

- **[Anora](https://www.imdb.com/title/tt28607951/)**: This was my first Sean Baker film and I can see why his work is so celebrated. It was so well-written that I went from heart-pounding anxiety, to laughing, and then to a heavy-hearted reflective silence.

- **[Conclave](https://www.imdb.com/title/tt20215234/)**: I feel comfortable saying I think this had the best acting of any film I saw from this year. Every single role felt perfectly cast. I was hesitant when I was told that it's a film full of twists, thinking that surely some of them must be an eye-rolling stretch. I was wrong. I never thought a political drama about the inner workings of religion would have me on the edge of my seat, but here we are.

- **[Alien: Romulus](https://www.imdb.com/title/tt18412256/)**: I largely agree with the general opinion of this one: It's a great return to horror, and Cailee Spaeny is amazing. I was a little lower on this one than most, but I still think it was a great watch. I wanted to put a spotlight on David Jonsson. Not only was he great as Andy in this film, I also loved his work in another film I watched this year: [Rye Lane](https://www.imdb.com/title/tt15893750/). These two roles couldn't be more different but I think he did such an amazing job in both.

## Anticipated 2025 films

This is far from a complete list, but these are the films of 2025 that I already have my eye on:

- [Mickey 17](https://www.imdb.com/title/tt12299608/)
- [28 Years Later](https://www.imdb.com/title/tt10548174/)
- [Untitled Paul Thomas Anderson Film](https://www.imdb.com/title/tt30144839/)
- [The Running Man](https://www.imdb.com/title/tt14107334/)
- [The Life of Chuck](https://www.imdb.com/title/tt12908150)
- [No Other Choice](https://www.imdb.com/title/tt1527793/)

## 2025 goals

Like 2024, I'm not going to aim for a specific number of films. I found that it places a lot of pressure on what should be an enjoyable hobby. Instead, I have two general goals:

1. I want to keep up with 2025 releases better. I ended up watching more 2024 films this year than I thought I would, but that's largely due to my end-of-year sprint.

2. I want to make an effort to watch more pre-1970s films. I started on this late in 2024, but it's a big gap in my viewing history.

## That's a wrap

This was a great year of film exploration for me. Across decades, genre, nations, and languages, I think I really expanded my appreciation for different styles. I have those around me to thank as well, as some of my favorite films I watched this year came from recommendations.

Writing the code to gather and analyze the data for this blog was a fun little project as well. I plan on cleaning it up and writing about it soon!