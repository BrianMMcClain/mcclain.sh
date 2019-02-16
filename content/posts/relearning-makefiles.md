---
title: "Relearning Makefiles"
date: 2019-01-23T16:50:50-05:00
draft: true
featuredImg: ""
tags: 
  - makefile
  - code
---

If I had to guess, it's been nearly a decade since I've last wrote a Makefile, which really is a shame. After all, what's a more iconic trio of commands in software development than:

```
$ ./configure
$ make
$ make install
```

While I'm not _quite_ brave enough to jump into [configure](https://en.wikipedia.org/wiki/Configure_script), I thought it's long overdue that I take another look at [make](https://linux.die.net/man/1/make). Even better, this blog is a great candidate. Previously, I was building and pushing this blog with a bash script:

```bash
#!/bin/bash

echo "Rebuilding and pushing to GitHub . . ."

hugo -t hermit

cd public
git add .
git commit -m "Site regenerated at `date`"
git push origin master

cd .
```

As you can see, it's not a complicate script. Like many, I have my `/public` directory set up as a submodule pointing to my [GitHub Pages](https://github.com/brianmmcclain/brianmmcclain.github.io) repository, so I can just regenerate the blog using the [Hugo](https://gohugo.io/) CLI and then push up the new changes. This works great as is, but a perfectly working solution never stopped anyone from completely rewriting it. Looking forward, maybe 