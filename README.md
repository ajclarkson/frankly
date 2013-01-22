# Frankly

Simple Web Publishing

Frankly is a lightweight web publishing platform that runs on the Sinatra framework. You simply write your content using markdown, create a few template files, and then stick everything in a git repository, Frankly takes care of the rest.

Primarily designed for writers who code, Frankly provides a stable platform for deploying any website to a Ruby server (such as Heroku). This repository contains all of the source code for the CMS and the frankly site, which it is powering, and as such is reasonably self documenting. 

## Getting Started

If you're raring to get stuck in with the default site and see just how easy it is to author content with Frankly, you only need four commands:
(_This assumes you have a Ruby environment installed_)

1. <code>git clone http://github.com:ajclarkson/frankly.git</code>
2. <code>cd frankly</code>
3. <code>bundle install</code>
4. <code>rackup</code>

By browsing to [http://127.0.0.1:9292](http://127.0.0.1:9292) you should now see a local version of this site, and that's it. Frankly is running.

## Adding a Page

Adding a page to your local development version is also incredibly simple. So let's add a new page. Leave the already running server running, and open a new terminal, then get to the folder where frankly is. To add a new page simply type:

<code>rake new_page</code>

You will be prompted to give a title, and then the page is generated, it'll be inside the <code>'pages'</code> folder. If you open it up you'll be faced with the front matter:

<code class="prettyprint linenums">---

title: Example Page

date: 2013-01-21 13:06

slug: example-page

author: ajclarkson

---</code>

This is all editable, as long as you keep the formatting. The title field is what will be used as link text in the navigation menus and will be displayed at the top of the new page. The slug meanwhile, is the url used to access that page. Beneath this, you can start writing in markdown and authoring your page. Once you've done that, all you need to do is update the site indexes, which is done with the following command:

<code>rake generate</code>

Refresh the site, and your new page will be part of the site navigation, and all should be working fine. Simple.

## Adding a new Blog Post

Blog posts work almost identically to adding new pages, except you create them with:

<code>rake new_post</code>

Other than that, follow the same procedure, editing the new file in the <code>'posts'</code> folder and running <code>rake generate</code> which will index the new blog post, and you'll be able to see it on the archive page.

## Customisation

Now that you know how to add content to the default site, you can get your hands dirty with the templating system. Everything is controlled using [HAML](http://haml.info) layouts and CSS files. The layouts can be found in the <code>'views'</code> folder, while the CSS, javascript, and images are all within <code>'public'</code>

Configuration options regarding the generation of your site can be found at the top of the <code>'Rakefile'</code>. These allow changes to items such as the default author name that gets added to posts.

When templating, leave the <code>'/views/shared/nav.haml'</code> file where it is, because any changes will just be overwritten next time you run the <code>rake generate</code> command. 

## Good Luck!

That should be plenty for you to get started using Frankly. The documentation will be updated as the CMS evolves, as will the blog on this site. It's early days yet, but Frankly can already provide a stable, fast, platform for your blog or site. Any questions / comments can be levied [@ajclarkson](http://twitter.com/ajclarkson), and issues can be posted through [GitHub](http://github.com/ajclarkson/frankly)

Thanks for checking out Frankly!

&mdash; Adam