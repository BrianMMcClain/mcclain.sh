---
title: "My 2025 Film Retrospective"
date: 2026-01-01T00:00:00-05:00
description: A reflection on the films that I watched in 2025.
---

Welcome to the new year!. It's that time again where I look back on all the films I watched in 2025, reflect, and look towards 2026.

This year has been an interesting one for me, both in the world of film and in my personal life. This meant I watched fewer films that I would have liked, but I still managed to enjoy so many incredible movies.

## 2025 goals

I wrote in my [2024 retrospective](/posts/2024-film-retro) that I had two goals for 2025:

1. Keep up with the 2025 releases better.
2. Watch more pre-1970s films.

Did I do these two things? Well, the data in this blog gives a more exact answer. In short though, I did a lot better at keeping up with current releases, and _way_ worse visiting the classics.

## Overall statistics

All of this data was pulled from my [Letterboxd diary](https://letterboxd.com/brianmmcclain/films/diary/for/2025), supplemented by the [TMDb API](https://developer.themoviedb.org/reference/intro/getting-started). 

If you've never talked movies with me, a fair warning: I like to use the whole scale between 0 and 10. To me, a 5 is an average film. I didn't love it, I didn't hate it.

**Total entries:** 137 (11.4 per month, 2.6 per week)  
**Unique films:** 136 (I watched [His Motorbike, Her Island (1986)](https://letterboxd.com/film/his-motorbike-her-island) twice)  
**Average rating:** 7.1  
**Films marked as liked:** 22  
**Films previously seen:** 10  
**2025 films watched:** 38  

**Total runtime:** 257h 34m  
**Average runtime:** 112.8 minutes  
**Longest film:** [The Brutalist (2024)](https://letterboxd.com/film/the-brutalist) (215 minutes)  
**Shortest film:** [Look Back (2024)](https://letterboxd.com/film/look-back-2024) (58 minutes)  
  
**First film of 2025:** [The Apartment (1960)](https://letterboxd.com/film/the-apartment)  
**Last film of 2025:** [The Spy Who Came In from the Cold (1965)](https://letterboxd.com/film/the-spy-who-came-in-from-the-cold)  
**Oldest film:** [The Shop Around the Corner (1940)](https://letterboxd.com/film/the-shop-around-the-corner)

**Film I rated highest above average:** [28 Days Later (2002)](https://letterboxd.com/film/28-days-later) (My rating: 9, Average rating: 7.5)  
**Film I rated lowest below average:** [Exit 8 (2025)](https://letterboxd.com/film/exit-8) (My rating: 3, Average rating: 6.2)  

**Most obscure film:** [The Best You Can (2025)](https://letterboxd.com/film/the-best-you-can) (841 ratings)  
**Most popular film:** [Sinners (2025)](https://letterboxd.com/film/sinners-2025) (2,991,539 ratings)  
**Highest rated film:** [Harakiri (1962)](https://letterboxd.com/film/harakiri) (9.4 from 196,177 ratings, my rating: 10)  
**Lowest rated film:** [Love Hurts (2025)](https://letterboxd.com/film/love-hurts-2025) (4.1 from 75,581 ratings, my rating: 4)  

This is a bit more data than I had last year, mostly since I didn't throw all of this together on New Year's Eve.

One interesting data point is that my average rating of all the films I watched in 2025 (7.1) is nearly identical to the films I watched in 2024 (7.2). I'm not sure if this means that I keep watching highly recommended films, or that I really like giving out 7s and 8s.

### Rating distribution

Below is the distribution of how I rated all of the films I watched in 2025.

{{< chart id="allRatings" title="Rating distribution of all watched films" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    datasets: [{
        label: '# of Films',
        data: [0,0,0,2,12,10,15,31,43,20,4],
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
|[0](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/0/)|0|
|[1](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/0.5/)|0|
|[2](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/1/)|0|
|[3](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/1.5/)|2|
|[4](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/2/)|12|
|[5](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/2.5/)|10|
|[6](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/3/)|15|
|[7](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/3.5/)|31|
|[8](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/4/)|43|
|[9](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/4.5/)|20|
|[10](https://letterboxd.com/brianmmcclain/diary/films/for/2025/rated/5/)|4|

As weird as it is to say, I took more "chances" this year when it came to film. Time is a valuable thing, and it's tough to convince myself to watch something that I'm not absolutely jazzed about. But this year I decided to give more films an honest shot. This resulted in more fours and fives, but there were a few special films I found in there too.

### Films by genre 

Below is a breakdown of films by genre. Films in TMDB’s database can have multiple tags, so the total count here doesn’t match the total number of films I watched.

{{< chart id="genre" title="Films by genre" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['Drama', 'Comedy', 'Thriller', 'Romance', 'Crime', 'Action', 'Horror', 'Science Fiction', 'Mystery', 'Fantasy', 'Adventure', 'History', 'Music', 'Animation', 'Family', 'Western', 'War', 'Documentary'],
    datasets: [{
        label: '# of Films',
        data: [76,47,38,28,22,22,19,19,16,16,14,7,7,4,2,2,1,1],
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

|Genre|Count|Percent
|------|-----|-----|
|Drama|76|55.47%|
|Comedy|47|34.31%|
|Thriller|38|27.74%|
|Romance|28|20.44%|
|Crime|22|16.06%|
|Action|22|16.06%|
|Horror|19|13.87%|
|Science Fiction|19|13.87%|
|Mystery|16|11.68%|
|Fantasy|16|11.68%|
|Adventure|14|10.22%|
|History|7|5.11%|
|Music|7|5.11%|
|Animation|4|2.92%|
|Family|2|1.46%|
|Western|2|1.46%|
|War|1|0.73%|
|Documentary|1|0.73%|

I've debated if I should even include this graph, since some tags are so ubiquitous that they're associated with a disproportional percentage of films. Even if a film only has vague comedic or dramatic elements, it's still categorized as a "Drama" or "Comedy".

### Films by language

Below is a breakdown of films by primary spoken language. Each film is only counted once, even if multiple languages are listed.

{{< chart id="language" title="Films by language" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['English', 'Japanese', 'French', 'Italian', 'Korean', 'Mandarin', 'Swedish', 'No Language', 'Indonesian', 'Norwegian', 'Thai'],
    datasets: [{
        label: '# of Films',
        data: [106,10,6,4,3,2,2,1,1,1,1],
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

|Language|Count|Percent
|------|-----|-----|
|English|106|77.37%|
|Japanese|10|7.30%|
|French|6|4.38%|
|Italian|4|2.92%|
|Korean|3|2.19%|
|Mandarin|2|1.46%|
|Swedish|2|1.46%|
|No Language|1|0.73%|
|Indonesian|1|0.73%|
|Norwegian|1|0.73%|
|Thai|1|0.73%|

This was one aspect that I didn't do as good of a job at in 2025 as I did in 2024. In 2024, I made it a point to explore films from many different countries, languages, and cultures. That said, there's still a lot of international films from 2025 that I want to watch, but haven't had a chance yet.

If you're curious about the film that has no language, that would be [Electroma (2006)](https://letterboxd.com/film/electroma/), Daft Punk's music-video-turned-film. Unlike [Interstella 5555 (2003)](https://letterboxd.com/film/interstella-5555-the-5tory-of-the-5ecret-5tar-5ystem/), which served as an animated film to accompany their 2001 album "Discovery", Electroma is a standalone film. Filming started as a music video for [Human After All](https://www.youtube.com/watch?v=PXYeARRyDWk), but expanded to a feature-length film instead.

> _"We never planned for it to happen, but after we directed the videos for our last album we decided to keep on working. We were in the shooting dynamic, so the movie came naturally. We didn't think too much. Whether it's making music or directing a video, whatever we do we do it quickly. When we have a good work dynamic we don't need to ask too many questions of each other."_
>
> -- Guy-Manuel de Homem-Christo

### Films by decade

Below is a breakdown of films by the decade they released.

{{< chart id="decade" title="Films by decade" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['1940', '1950', '1960', '1970', '1980', '1990', '2000', '2010', '2020'],
    datasets: [{
        label: '# of Films',
        data: [9,4,10,4,12,7,19,7,65],
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

|Decade|Count|Percent
|------|-----|-----|
|[1940](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/1940s/)|9|6.57%|
|[1950](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/1950s/)|4|2.92%|
|[1960](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/1960s/)|10|7.30%|
|[1970](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/1970s/)|4|2.92%|
|[1980](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/1980s/)|12|8.76%|
|[1990](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/1990s/)|7|5.11%|
|[2000](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/2000s/)|19|13.87%|
|[2010](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/2010s/)|7|5.11%|
|[2020](https://letterboxd.com/brianmmcclain/diary/films/for/2025/decade/2020s/)|65|47.45%|

I technically accomplished my goal of watching more films from the 60's and earlier, but just barely. Last year I watched 20 films released prior to 1970, this year I watched 23. On the other hand, by percentage that means 16.8% of films I watched this year fell into that category, compared to 11.4% last year. That said, some of my favorites I watched in 2025 fit in these 23 films:

- [The Apartment (1960)](https://letterboxd.com/film/the-apartment/)
- [Harakiki (1962)](https://letterboxd.com/film/harakiri/)
- [Gilda (1946)](https://letterboxd.com/film/gilda/)
- [Brief Encounter (1945)](https://letterboxd.com/film/brief-encounter/)
- [Double Indemnity (1944)](https://letterboxd.com/film/double-indemnity/)

### Films by country

Below is a breakdown of films countries of production.

{{< chart id="country" title="Films by country" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['United States of America', 'United Kingdom', 'France', 'Japan', 'Italy', 'Germany', 'Canada', 'South Korea', 'Spain', 'Ireland', 'New Zealand', 'China', 'Finland', 'Sweden', 'Colombia', 'Taiwan', 'Indonesia', 'Portugal', 'Chile', 'Hong Kong', 'Tunisia', 'Thailand', 'Denmark', 'Poland', 'Norway'],
    datasets: [{
        label: '# of Films',
        data: [100,23,19,17,10,8,6,4,3,3,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1],
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

|Country|Count|Percent
|------|-----|-----|
|United States of America|100|72.99%|
|United Kingdom|23|16.79%|
|France|19|13.87%|
|Japan|17|12.41%|
|Italy|10|7.30%|
|Germany|8|5.84%|
|Canada|6|4.38%|
|South Korea|4|2.92%|
|Spain|3|2.19%|
|Ireland|3|2.19%|
|New Zealand|2|1.46%|
|China|2|1.46%|
|Finland|2|1.46%|
|Sweden|2|1.46%|
|Colombia|1|0.73%|
|Taiwan|1|0.73%|
|Indonesia|1|0.73%|
|Portugal|1|0.73%|
|Chile|1|0.73%|
|Hong Kong|1|0.73%|
|Tunisia|1|0.73%|
|Thailand|1|0.73%|
|Denmark|1|0.73%|
|Poland|1|0.73%|
|Norway|1|0.73%|

I debated for a long time about how I wanted to present this data. When someone says a film is a "French" film or a "Japanese" film, they often mean that the film was filmed in that country or in that language. Last year, I [spoke about](/posts/2024-film-retro/#2024-goals) how films are the work of many hands. Because of this, I decided to count all countries involved in the production.

### Highest rated films

Below are the films that I watched in 2025 that I gave a rating of 9 or 10. Some of these I've seen before (I've seen the Lord of the Rings trilogy probably a dozen times), but that's what makes these films so great. Other than the rating, these are in no particular order.

|Title|Rating|
|------|-----|
|[Harakiri](https://letterboxd.com/film/harakiri/)|10|
|[Perfect Days](https://letterboxd.com/film/perfect-days-2023/)|10|
|[The Lord of the Rings: The Fellowship of the Ring](https://letterboxd.com/film/the-lord-of-the-rings-the-fellowship-of-the-ring/)|10|
|[The Lord of the Rings: The Two Towers](https://letterboxd.com/film/the-lord-of-the-rings-the-two-towers/)|10|
|[Blue Velvet](https://letterboxd.com/film/blue-velvet/)|9|
|[Yojimbo](https://letterboxd.com/film/yojimbo/)|9|
|[The Seventh Seal](https://letterboxd.com/film/the-seventh-seal/)|9|
|[The Elephant Man](https://letterboxd.com/film/the-elephant-man/)|9|
|[The Great Dictator](https://letterboxd.com/film/the-great-dictator/)|9|
|[Sing Sing](https://letterboxd.com/film/sing-sing-2023/)|9|
|[Nickel Boys](https://letterboxd.com/film/nickel-boys/)|9|
|[Brief Encounter](https://letterboxd.com/film/brief-encounter/)|9|
|[Kiki's Delivery Service](https://letterboxd.com/film/kikis-delivery-service/)|9|
|[Long Day's Journey Into Night](https://letterboxd.com/film/long-days-journey-into-night-2018/)|9|
|[What's Up, Doc?](https://letterboxd.com/film/whats-up-doc-1972/)|9|
|[Double Indemnity](https://letterboxd.com/film/double-indemnity/)|9|
|[The Great Beauty](https://letterboxd.com/film/the-great-beauty/)|9|
|[Lost in Translation](https://letterboxd.com/film/lost-in-translation/)|9|
|[The Apartment](https://letterboxd.com/film/the-apartment/)|9|
|[The Blues Brothers](https://letterboxd.com/film/the-blues-brothers/)|9|
|[28 Days Later](https://letterboxd.com/film/28-days-later/)|9|
|[No Other Choice](https://letterboxd.com/film/no-other-choice-2025/)|9|
|[Casablanca](https://letterboxd.com/film/casablanca/)|9|
|[Charade](https://letterboxd.com/film/charade/)|9|

## 2025 films

Like every year, not every 2025 film was released in 2025. Between festivals and difference in international release dates, a few of these dropped ahead of the year. For this list, I’m going off of the US release date.

The list below is in my personal favorite order, at least as of the time that I'm writing this. This order has changed throughout the year, and I'm sure it will change again.

|Title|Rating|
|------|-----|
|[No Other Choice](https://letterboxd.com/film/no-other-choice-2025/)|9|
|[One Battle After Another](https://letterboxd.com/film/one-battle-after-another/)|8|
|[Blue Moon](https://letterboxd.com/film/blue-moon-2025/)|8|
|[Sinners](https://letterboxd.com/film/sinners-2025/)|8|
|[The Life of Chuck](https://letterboxd.com/film/the-life-of-chuck/)|8|
|[Weapons](https://letterboxd.com/film/weapons-2025/)|8|
|[Freaky Tales](https://letterboxd.com/film/freaky-tales/)|8|
|[The Ballad of Wallis Island](https://letterboxd.com/film/the-ballad-of-wallis-island/)|8|
|[Nouvelle Vague](https://letterboxd.com/film/nouvelle-vague-2025/)|7|
|[The Mastermind](https://letterboxd.com/film/the-mastermind-2025/)|7|
|[Bugonia](https://letterboxd.com/film/bugonia/)|7|
|[Eddington](https://letterboxd.com/film/eddington/)|7|
|[Frankenstein](https://letterboxd.com/film/frankenstein-2025/)|7|
|[28 Years Later](https://letterboxd.com/film/28-years-later/)|7|
|[The Naked Gun](https://letterboxd.com/film/the-naked-gun/)|7|
|[Misericordia](https://letterboxd.com/film/misericordia-2024/)|7|
|[The Running Man](https://letterboxd.com/film/the-running-man-2025/)|7|
|[The Phoenician Scheme](https://letterboxd.com/film/the-phoenician-scheme/)|6|
|[Companion](https://letterboxd.com/film/companion-2025/)|6|
|[Mickey 17](https://letterboxd.com/film/mickey-17/)|6|
|[The Luckiest Man in America](https://letterboxd.com/film/the-luckiest-man-in-america/)|6|
|[Black Bag](https://letterboxd.com/film/black-bag-2025/)|6|
|[Wake Up Dead Man](https://letterboxd.com/film/wake-up-dead-man/)|6|
|[The Long Walk](https://letterboxd.com/film/the-long-walk-2025/)|5|
|[Jay Kelly](https://letterboxd.com/film/jay-kelly/)|5|
|[The Roses](https://letterboxd.com/film/the-roses-2025/)|5|
|[Now You See Me: Now You Don't](https://letterboxd.com/film/now-you-see-me-now-you-dont-2025/)|5|
|[Honey Don't!](https://letterboxd.com/film/honey-dont/)|4|
|[Highest 2 Lowest](https://letterboxd.com/film/highest-2-lowest/)|4|
|[The Amateur](https://letterboxd.com/film/the-amateur-2025/)|4|
|[Happy Gilmore 2](https://letterboxd.com/film/happy-gilmore-2/)|4|
|[Good Fortune](https://letterboxd.com/film/good-fortune-2025/)|4|
|[Thunderbolts*](https://letterboxd.com/film/thunderbolts/)|4|
|[Materialists](https://letterboxd.com/film/materialists/)|4|
|[Love Hurts](https://letterboxd.com/film/love-hurts-2025/)|4|
|[The Best You Can](https://letterboxd.com/film/the-best-you-can/)|4|
|[The Thursday Murder Club](https://letterboxd.com/film/the-thursday-murder-club/)|4|
|[Exit 8](https://letterboxd.com/film/exit-8/)|3|

There were plenty of wonderful films from 2025 that I haven't had the chance to see yet, many of which will easily shake up this list. 

- [Marty Supreme](https://letterboxd.com/film/marty-supreme/)
- [Sentimental Value](https://letterboxd.com/film/sentimental-value-2025/)
- [It Was Just An Accident](https://letterboxd.com/film/it-was-just-an-accident/)
- [Sirāt](https://letterboxd.com/film/sirat-2025/)
- [The Secret Agent](https://letterboxd.com/film/the-secret-agent-2025/)
- [Resurrection](https://letterboxd.com/film/resurrection-2025/)
- [Hamnet](https://letterboxd.com/film/hamnet/)
- [Rental Family](https://letterboxd.com/film/rental-family-2025/)
- [Father Mother Sister Brother](https://letterboxd.com/film/father-mother-sister-brother/)
- [Left-Handed Girl](https://letterboxd.com/film/left-handed-girl/)
- [The Testament of Ann Lee](https://letterboxd.com/film/the-testament-of-ann-lee/)

### 2025 rating distribution

Below is the distribution of how I rated the films released in 2025 that I watched.

{{< chart id="thisYearRatings" title="Rating distribution 2025 films" width="100" >}}

{
 type: 'bar',
 data: {
    labels: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    datasets: [{
        label: '# of Films',
        data: [0,0,0,1,10,4,6,9,7,1,0],
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
|3|1|
|4|10|
|5|4|
|6|6|
|7|9|
|8|7|
|9|1|
|10|0|

Despite the increase of films I rated below 5 compared to 2024, I actually think this year had so many amazing movies. A 7 is something I'd easily recommend to a friend, and an 8 I've probably annoyed that friend talking about it one too many times.

### 2025 highlights

Some of these weren't even my top rated films, but there were pieces that I appreciated so deeply that I felt like it'd be a shame not to put a spotlight on:

- **[No Other Choice](https://letterboxd.com/film/no-other-choice-2025/):** My favorite of 2025. There are so many interesting things going on throughout this entire movie. The camera work, the sound design, and the music choice are all spot on. The plot makes you swear you know exactly where it's going but swerves at the last second.
- **[Blue Moon](https://letterboxd.com/film/blue-moon-2025/):** For a few days after watching this one I was almost ready to call it my favorite of 2025. Richard Linklater and Ethan Hawke truly are a legendary duo. Hawke had more dialogue crammed in this 100 minute film than any other movie I can think of, and I could have listened to him for another 100. Beautiful, funny, devastating, and a must-see.
- **[Freaky Tales](https://letterboxd.com/film/freaky-tales/):** Far and away the most unique and fun film of 2025 that I saw. It has its share of flaws, but by the time the credits rolled I was still sitting there with a smile on my face, already wanting to rewatch it.
- **[One Battle After Another](https://letterboxd.com/film/one-battle-after-another/):** This was the definition of suspense. The final scene has been talked about ever since this film released, and with good reason.
- **[Nouvelle Vague](https://letterboxd.com/film/nouvelle-vague-2025/):** I can't get over how much detail was put into recreating 1959 Paris. A must-see if you're a fan of [Breathless (1960)](https://letterboxd.com/film/breathless/), 

## Anticipated 2026 films

This is far from a complete list, but these are the films of 2026 that I already have my eye on:

- [The Entertainment System Is Down](https://letterboxd.com/film/the-entertainment-system-is-down/)
- [Werwulf](https://letterboxd.com/film/werwulf/)
- [Godzilla Minus Zero](https://letterboxd.com/film/godzilla-minus-zero/)
- [28 Years Later: The Bone Temple](https://letterboxd.com/film/28-years-later-the-bone-temple/)
- [The Odyssey](https://letterboxd.com/film/the-odyssey-2026/)
- [Project Hail Mary](https://letterboxd.com/film/project-hail-mary/)
- [Dune: Part 3](https://letterboxd.com/film/dune-part-three/)

Like 2025, I'll be keeping a list of the films of 2026 that catch my interest in a Letterboxd list [here](https://letterboxd.com/brianmmcclain/list/2026/).

## 2026 goals

Like 2025, I'm not going to aim for a specific number of films. I'd like to cross 100 as I usually do, as it lets me spend time with a hobby I love without keeping me from my other favorite hobbies. While I think I did a pretty good job at my goal of keeping up with 2025 releases, I fell short of my other goal of watching more films releases prior to 1970. Funny enough, I got on a kick of classic films at the very end of the year, watching [In A Lonely Place (1950)](https://letterboxd.com/film/in-a-lonely-place/), [Double Indemnity (1944)](https://letterboxd.com/film/double-indemnity/), and [The Spy Who Came In from the Cold (1965)](https://letterboxd.com/film/the-spy-who-came-in-from-the-cold/) in December.

For 2025, I have three goals:

1. Make good on my previous goal to watch more pre-1970s films.
1. Get back to making time for more films created outside of the United States.
1. Continue to keep up with new releases.

In addition to this, while not a specific goal, I'd like to get to the theater more. I grew up going as often as I could, but in recent years I've opted to wait for streaming so I could watch at home. There's something about sitting there in front of the big screen, popcorn in hand, 

## That's a wrap

This was a great year of film for me, and 2025 had so may great releases. I'm looking forward to seeing what 2026 brings!

Want to chat about movies? Add me on [Letterboxd](https://letterboxd.com/brianmmcclain/)!