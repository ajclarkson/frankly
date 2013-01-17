# Frankly

Simple Web Publishing

Frankly is a lightweight web publishing platform that runs on the Sinatra framework. You simply write your content using markdown, create a few template files, and then stick everything in a git repository, Frankly takes care of the rest.

Primarily designed for writers who code, Frankly provides a stable platform for deploying any website to a Ruby server (such as Heroku). This repository contains all of the source code for the CMS and the frankly site, which it is powering, and as such is reasonably self documenting. 

## Limitations

It's early days yet, so Frankly can only handle static page websites at the moment. Simply create a markdown file in the <code>'pages'</code> directory, and run <code>'rake generate'</code> then push it to your git repository on your server and your site will be live.

## Coming soon...

I'm already writing the blogging engine that will automatically index posts and provide the means for a different template to be added to blog posts than pages. 

I'm also thinking about ways to smooth the deployment process and make things even more automated!

In the meantime, any questions, find me on twitter [@ajclarkson](http://twitter.com/ajclarkson)