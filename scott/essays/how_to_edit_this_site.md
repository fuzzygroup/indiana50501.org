# How to Edit This Site

Indiana 50501 now has a website.  And it is a site that anyone in the community can edit / improve / add pages to.  Here's how this works:

1. To edit the site, you need an account on [GitHub](https://www.github.com).  GitHub is a software development tool that does what is called *version control*.  Version control is the idea that when you change something, you should be able to know what changed, who changed it, etc.  So step 1 is make a github account.
2. Next you need to get that account to Scott via a Signal message, email, passing a note in class, smoke signal, bribing him with a diet soft drink, etc.  Scott will then add you to the "repository" (the collection of files that represent our website).
3. Next you need to goto the [repository](https://github.com/fuzzygroup/indiana50501.org) and find what you want to edit.  This looks very much like a file browser.  
4. Let's say you want to add your personal social media links to the links page.  Scroll down to where you see **links.md** and click on it.
5. This opens it and now you can click the pencil icon to edit it.  And what you will see is **not** HTML but instead what is called Markdown (see below).  Scroll down and find the very last section and you will see a block starting with "Personal Social Media Links".  This is where your link goes.  Now this content is written with Markdown (actually our whole site is Markdown).  Markdown is a simplified way to write content and have it *automagically* translated to HTML.  See Sidebar: "Markdown Basics".
6. If you have multiple social media links you want to include, copy the block for Scott and paste it in below Brian (or whoever).  Adjust the link anchor and link destination.  If you have a single social media link you want to include, copy the block for Brian and paste it in below and then make the edits as needed.
7.  When you are done, scroll the screen up and click the Commit Changes button.  Enter a description of your changes "Tori's social links" and click Commit Changes. 
8. This sends the changes to the server and the next time the site gets deployed, they will be displayed.  Normally I try to deploy every day around 5:45.  


## Sidebar: Markdown Basics

Markdown is an internet creation by Jon Gruber who wanted a way to more easily write his blog posts.  He wrote a spec which said things like:

* Headings should start with a hash tag character at the left most column followed by a space followed by the text of the heading
* A second level heading should start with two hash tags at the start of the line, ...
* A paragraph of body text should be just that -- text
* A bulleted list should start with an asterisk and then the text
* A numbered list should start with a number, a period and then the text 
* A hyperlink has its anchor surrounded by square braces and then parentheses which surround the destination of the link

Here are two Markdown tutorials:

* [Markdown Tutorial](https://www.markdowntutorial.com/)
* [Markdown Guide](https://www.markdowntutorial.com/)

