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
require 'stringex'


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
				:slug => "/"+page
				})
			
		end
	}
	File.open('./views/shared/nav.haml', 'w'){ |f|
		f.write("%nav\n\t%ul\n")
		pages.each do |page|
			f.write("\t\t%li\n\t\t\t%a{:href=>'" + page[:slug] + "'} " + page[:title] + "\n")
		end
	}

	Rake::Task["generate_post_index"].execute

end 

task :generate_post_index do
	posts = []
	files = Dir.glob("posts/*")
	files.each do |file|
		file_contents = File.read(file)
		begin
			if (markdown = file_contents.match(/^(?<headers>---\s*\n.*?\n?)^(---\s*$\n?)/m))
				article = markdown.post_match
				metadata = YAML.load(markdown[:headers])
				posts.push({
					:filename => File.basename(file, '.*'),
					:title => metadata['title'],
					:slug => "/blog/"+metadata['slug'],
					:date => metadata['date'],
					:next => "",
					:previous => ""
					})
			end
		rescue => e
			 puts "YAML Exception reading #{file}: #{e.message}"
		end	
	end
	posts = posts.sort_by{|post| post[:date]}.reverse
	posts.each_with_index do |post, index|
		if index != 0
			post[:next] = posts[index-1][:slug]
		end

		if index != posts.size-1
			post[:previous] = posts[index+1][:slug]
		end
	end
	File.open('_post-index.yaml', 'w+'){ |f|
		f.write posts.sort_by{|post| post[:date]}.reverse.ya2yaml
	}
end

task :new_post, :title do |t, args|
	if args.title
		title = args.title
	else
		title = get_stdin("Enter a title for your new post: ")
	end

	filename = "./posts/#{Time.now.strftime('%Y-%m-%d')}-#{title.to_url}.md"
	puts "Creating new post: #{filename}"
	File.open(filename, 'w+') do |post|
		post.puts("---")
		post.puts("title: #{title}")
		post.puts("date: #{Time.now.strftime('%Y-%m-%d %H:%M')}")
		post.puts("slug: #{title.to_url}")
		post.puts("---")
	end
end
def get_stdin(message)
  print message
  STDIN.gets.chomp
end