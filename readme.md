# Understanding Scott's Whacky Website Builder aka Polimark

Polimark -- "Political website building via Markup"

My secret admission is that I still hate writing HTML even after writing it for 31 years.  I tried writing the initial 50501 website using raw HTML and I kept putting it off because I just hate writing HTML but ... **I love Markdown**.

So I wrote a static site generator -- Polimark -- that compiles Markdown files right into HTML and then moves them to github so that people other than me can update the site (not all of this is fully done yet but the architecture is there).

Here were my assumptions building this:

1. I, Scott, can't be the bottle neck for getting content onto our web site.
2. Markdown is simple enough for most people to use it.
3. Github gives a simple CMS that most people can use albeit with training.
4. Most websites of the type we need are informational in nature.  
5. Privacy and avoiding tracking is paramount in today's adversarial environment.
6. The modern web is a tracking nightmare.

Point 6 was what led me to write a clean slate approach to publishing our website:

1. Its about 120 lines of Ruby.
2. I know every dependency and I trust all of them.
3. No cookies, node modules or anything else.
4. It is a straight forward static site generator:

* read a list of directories
* process the markdown files in the directory
* add header and footer to each markdown file
* lather / rinse / repeat

Yes other tools like this exist but I don't know what lurks in their bowels so ...