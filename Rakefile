## Site Configuration Variables

show_home_link				=	false	#Should an automatically generated 'Home' link be added to site navigation
show_blog_link				=	true	# Show automatically generated 'Blog' link in the menu
page_title_as_link_text		=	true 	# Use first h1 in the page markdown as the link text for menu
									 	# Otherwise, the filename will be used




##### DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU"RE DOING! 

require 'rubygems'
require 'bundler/setup'
require 'rdiscount'
require 'nokogiri'
require 'yaml'
require 'ya2yaml'

desc "Generate Page Navigation"
task :generate do 
	pages = []
	
	if show_home_link
		pages.push({
			:title => "Home",
			:slug => '/'
			})
	end

	if show_blog_link
		pages.push({
			:title => "Blog",
			:slug => '/blog'
			})
	end
	Dir['pages/*'].map { |p| page = File.basename(p, '.*')
		@page_content = RDiscount.new(File.open(p).read).to_html
		page_title = Nokogiri::HTML::DocumentFragment.parse(@page_content).css('h1').inner_html()
		
		unless File.basename(p) == "index.md"
			unless page_title_as_link_text
				page_title == page

			end
			pages.push({
				:title => page_title,
				:slug => page
				})
			
		end
	}
	File.open('./views/shared/nav.haml', 'w'){ |f|
		f.write("%nav\n\t%ul\n")
		pages.each_with_index do |page|
			f.write("\t\t%li\n\t\t\t%a{:href=>'" + page[:slug] + "'} " + page[:title] + "\n")
		end
	}

	posts = []

	Dir['posts/*'].map { |p| post = File.basename(p, '.*')
		@post_content = RDiscount.new(File.open(p).read).to_html
		post_title = Nokogiri::HTML::DocumentFragment.parse(@post_content).css('h1').inner_html()

		posts.push({
			:title => post_title,
			:slug => "/blog/"+post
			})

	}

	File.open('_post-index.yaml', 'w'){ |f|
		f.write posts.ya2yaml

	}



end 