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

$KCODE = "U"

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
		pages.each do |page|
			f.write("\t\t%li\n\t\t\t%a{:href=>'" + page[:slug] + "'} " + page[:title] + "\n")
		end
	}

	posts = []
	files = Dir.glob("posts/*").reverse
	files.each_with_index do |file, index|
		post = File.basename(file, '.*')
		@post_content = RDiscount.new(File.open(file).read).to_html
		post_title = Nokogiri::HTML::DocumentFragment.parse(@post_content).css('h1').inner_html()
		next_file = previous_file = ""
		if index != 0 && !File.basename(next_file, '.*').nil?
			next_file = "/blog/"+File.basename(files[index-1], '.*')
			puts next_file
		end

		if index != files.size-1 && !File.basename(previous_file, '.*').nil?
			previous_file = "/blog/"+File.basename(files[index+1], '.*')
			puts previous_file
		end

		posts.push({
			:title => post_title,
			:slug => "/blog/"+post,
			:moddate => File.mtime(file),
			:next => next_file,
			:previous => previous_file
			})
	end

	File.open('_post-index.yaml', 'w'){ |f|
		f.write posts.sort_by{|post| post[:moddate]}.reverse.ya2yaml

	}


end 