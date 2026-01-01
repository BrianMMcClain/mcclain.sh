---
title: "My 2025 Film Retrospective"
date: 2025-10-31T10:24:29-05:00
description: A reflection on the films that I watched in 2025.
draft: true
---

It's that time of year again. Time to look back on all the films watched in 2025, reflect, and look towards 2026.

## 2025 goals

I wrote in my [2024 retrospective](/posts/2024-film-retro) that I had two goals for 2025:

1. Keep up with the 2025 releases better.
2. Watch more pre-1970s films.

Did I do these two things? Well, the data in this blog gives a more exact answer. In short though, I did a lot better at keeping up with current releases, and _way_ worse visiting the classics.

## Overall statistics

All of this data was pulled from my [Letterboxd diary](https://letterboxd.com/brianmmcclain/films/diary/for/2025), supplemented by the [TMDb API](https://developer.themoviedb.org/reference/intro/getting-started). 

If you've never talked movies with me, a fair warning: I like to use the whole scale between 0 and 10. To me, a 5 is an average film. I didn't love it, I didn't hate it.

Below are 

**Total entries:** 137 (11.4 per month, 2.6 per week)  
**Unique films:** 136 (I watched [His Motorbike, Her Island (1986)](https://letterboxd.com/film/his-motorbike-her-island) twice)  
**Average rating:** 7.1  
**Films liked:** 22  
**Films rewatched:** 10  
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

This is a bit more data than last year, mostly since I didn't throw all of this together on New Year's Eve. I watched fewer films in 2025 than I did in 2024 (175), but I did a better job at keeping up with new releases, more on that later.

One interesting data point is that my average rating of all the films I wathed in 2025 (7.1) is nearly identical to the films I watched in 2024 (7.2).

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

### Filmes by genre 

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

I've debated if I should even include this graph, since some tags are so ubiquitous that they apply to more films than they don't. Even if a film only has vague comedic or dramatic elements, it's still categorized as a "Drama" or "Comedy".

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

This was one aspect that I didn't do as good of a job at in 2025 as I did in 2024. In 2024, I made it a point to explore films from many different countries, languages, and cultures. That said, there's still a lot of international films from 2025 that I want to watch, but haven't had a chance or they aren't available near me yet.

If you're curious about the film that has no languange, that would be [Electroma (2006)](https://letterboxd.com/film/electroma/), Daft Punk's music-video-turned-film. Unlike [Interstella 5555 (2003)](https://letterboxd.com/film/interstella-5555-the-5tory-of-the-5ecret-5tar-5ystem/), which served as an animated film to acompany their 2001 album "Discovery", Electroma is a standalone film. Filming started as a music video for [Human After All](https://www.youtube.com/watch?v=PXYeARRyDWk), but expanded to a feature-length film instead.

> _"We never planned for it to happen, but after we directed the videos for our last album we decided to keep on working. We were in the shooting dynamic, so the movie came naturally. We didn't think too much. Whether it's making music or directing a video, whatever we do we do it quickly. When we have a good work dynamic we don't need to ask too many questions of each other."_
>
> -- Guy-Manuel de Homem-Christo

### Films by decade

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

## 2025 films

### 2025 highlights

- **[No Other Choice](https://www.imdb.com/title/tt1527793):** I think I've landed on this one as my favorite of 2025. There are so many interesting things going on throughout this entire movie. The camera work, the sound design and music choice, the plot that you swear you know exactly where it's going but swerves at the last second.
- **[Freaky Tales](https://www.imdb.com/title/tt21942598):** Far and away the most unique and fun film of 2025 that I saw. It has its share of flaws, but by the time the credits rolls I was still sitting there with a smile on my face, already wanting to rewatch it.
- **[Blue Moon](https://www.imdb.com/title/tt32536315):** Richard Linklater and Ethan Hawke truly are a legendary duo. Hawke had more dialogue crammed in this 100 minute film than any other movie I can think of, and I could have listened to him for another 100. Beautiful, funny, devastating, and a must-see.
- **[One Battle After Another](https://www.imdb.com/title/tt30144839):** This was the definition of suspense. The final scene has been talked about ever since this film released, and with good reason. 