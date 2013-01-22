---
title: Download
date: 2013-01-21 13:06
slug: get-frankly
author: ajclarkson
---

The aim of Frankly was that to use it, you wouldn't particularly have to know how it works. It is designed with people who code in mind, but you certainly don't have to be a developer to get to grips with all of this. I think that's certainly true as well, you can head over to the [GitHub repo](http://github.com/ajclarkson/frankly) right now, and grab the code for this very site. That should be as much documentation as you'd need. Just in case though, there's a few hints and tips on this page as well.

## Getting Started

If you're raring to get stuck in with the default site and see just how easy it is to author content with Frankly, you only need four commands:
(_This assumes you have a Ruby environment installed_)

	git clone http://github.com:ajclarkson/frankly.git
	cd frankly
	bundle install
	rackup

By browsing to [http://127.0.0.1:9292](http://127.0.0.1:9292) you should now see a local version of this site, and that's it. Frankly is running.

## Adding a Page

Adding a page to your local development version is also incredibly simple. So let's add a new page. Leave the already running server running, and open a new terminal, then get to the folder where frankly is. To add a new page simply type:

	rake new_page

You will be prompted to give a title, and then the page is generated, it'll be inside the __'pages'__ folder. If you open it up you'll be faced with the front matter:

	title: Example Page
	date: 2013-01-21 13:06
	slug: example-page
	author: ajclarkson


This is all editable, as long as you keep the formatting. The title field is what will be used as link text in the navigation menus and will be displayed at the top of the new page. The slug meanwhile, is the url used to access that page. Beneath this, you can start writing in markdown and authoring your page. Once you've done that, all you need to do is update the site indexes, which is done with the following command:

	rake generate

Refresh the site, and your new page will be part of the site navigation, and all should be working fine. Simple.

## Adding a new Blog Post

Blog posts work almost identically to adding new pages, except you create them with:

	rake new_post

Other than that, follow the same procedure, editing the new file in the __'posts'__ folder and running __rake generate__ which will index the new blog post, and you'll be able to see it on the archive page.

## Customisation

Now that you know how to add content to the default site, you can get your hands dirty with the templating system. Everything is controlled using [HAML](http://haml.info) layouts and CSS files. The layouts can be found in the __'views'__ folder, while the CSS, javascript, and images are all within __'public'__

Configuration options regarding the generation of your site can be found at the top of the __'Rakefile'__. These allow changes to items such as the default author name that gets added to posts.

When templating, leave the __'/views/shared/nav.haml'__ file where it is, because any changes will just be overwritten next time you run the __rake generate__ command. 

## Good Luck!

That should be plenty for you to get started using Frankly. The documentation will be updated as the CMS evolves, as will the blog on this site. It's early days yet, but Frankly can already provide a stable, fast, platform for your blog or site. Any questions / comments can be levied [@ajclarkson](http://twitter.com/ajclarkson), and issues can be posted through [GitHub](http://github.com/ajclarkson/frankly)

Thanks for checking out Frankly!

&mdash; Adam