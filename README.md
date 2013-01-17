# Frankly

Simple Web Publishing

Frankly is a lightweight web publishing platform that runs on the Sinatra framework. You simply write your content using markdown, create a few template files, and then stick everything in a git repository, Frankly takes care of the rest.

Primarily designed for writers who code, Frankly provides a stable platform for deploying any website to a Ruby server (such as Heroku). This repository contains all of the source code for the CMS and the frankly site, which it is powering, and as such is reasonably self documenting. 

For the most basic functionality, you can start creating pages and blog posts straight away. Simply create a markdown file in either the <code>pages</code> or <code>posts</code> folders (or both!) and run <code>rake generate</code>. Then startup the app as you would with any other Rack based Sinatra app (<code>rackup app.rb</code>) and browse to localhost:9292 to see your site in all of it's glory. To complement your great content explore the template files in the <code>'views'</code> folder, and the relevant asset files in <code>'public'</code>. 

## Limitations

The blog functionality is extremely limited at the moment. The other stuff is currently under development, including actually displaying post dates, and providing previous/next navigation amongst other things.

Also in the meantime, if you are using this experimental early version of frankly, every time you pull from the git repo it could overwrite your custom layout/posts etc. Eventually, by the first proper release, all of that gubbins will be seperated out into a different directory so that it won't overwrite any changes you make, and an update will be a simple git pull away.


## Coming soon...

All sorts really, more advanced blogging, RSS feeds, and a few other ideas that are still floating around my head at the minute.

I'm also thinking about ways to smooth the deployment process and make things even more automated!

In the meantime, any questions, find me on twitter [@ajclarkson](http://twitter.com/ajclarkson)