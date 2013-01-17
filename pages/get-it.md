# Download

The aim of Frankly was that to use it, you wouldn't particularly have to know how it works. It is designed with people who code in mind, but you certainly don't have to be a developer to get to grips with all of this. I think that's certainly true as well, you can head over to the [GitHub repo](http://github.com/ajclarkson/frankly) right now, and grab the code for this very site. That should be as much documentation as you'd need. Just in case though, there's a few hints and tips on this page as well.

## Requirements

You should have some knowledge of Ruby. By this I mean you should know how to install a Ruby development environment, and optionally how to deploy to something like Heroku if you so desire. You __don't__ need to know how to write a CMS in Ruby, so don't be daunted. I've done that part for you.

As for the templates and such, they are all created using the [HAML](http://haml.info) language at the minute. If you've never used HAML before in your life, don't worry because you can, though I recommend using HAML, replace it with HTML and the site will still function fine. Infact you will notice in the templates in use here, there is some embedded HTML that I may have been too lazy to convert to HAML...

## Templates

Everything you need to edit about the templates live in one of two places. The <code>'views'</code> directory holds all of your template files. The <code>'public'</code> directory holds all css/javascript/image assets related to presentation. 

In the <code>'views'</code> folder, you'll find a <code>'layout.haml'</code> file, which is the core of your template. This determines the HTML head content and other elements that will be the same across all pages. Then you'll also see a <code>'page.haml'</code> file. This is specifically the layout of 'pages'. That will make slightly more sense when the blog is functional, and there will be a seperate template for those articles. These specifics slot into the larger <code>'layout.haml'</code> where the <code> =yield</code> appears. 

One thing to note is the <code>'/shared/nav.haml'</code>, while you can manually edit this, know that the next time you run the site generation, it will be automatically overwritten to contain a link to each page on the site. 
Taking a look at the sources on the [GitHub repo](http://github.com/ajclarkson/frankly) will probably help understanding that. It's simple, <em>honestly</em>.

## Adding a Page

As an example of just how easy Frankly is to use, here's the complete process of adding a new page to your site.

1. Create a new markdown file in the <code>'pages'</code> directory, and type away to your hearts content.
1. Type <code>rake generate</code> into your terminal to update your navigation.
1. Commit and push your changes via git
1. Enjoy your new page.