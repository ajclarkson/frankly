## Site Configuration Variables

show_home_link				=	false			# Should an automatically generated 'Home' link be added to site navigation
show_blog_link				=	true			# Show automatically generated 'Blog' link in the menu
blog_link_name				=	"Blog"			# Link text to be used for the 'Blog' link
default_author				=	"ajclarkson"	# Name attributed to authoring pages/blog posts by default. Can be 
												# overridden in the page/post front matter

##### DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU"RE DOING! 

require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'ya2yaml'
require 'stringex'

task :generate do
	puts "Generating your site..."
	Rake::Task["generate_page_navigation"].execute
	Rake::Task["generate_post_index"].execute
	puts "Completed successfully. Deploy your site to make changes live!"
end 

task :generate_page_navigation do
	puts "Creating Site Navigation..."
	pages = []
	if show_home_link
		pages.push({
			:title => "Home",
			:slug => '/'
			})
	end

	if show_blog_link
		pages.push({
			:title => blog_link_name,
			:slug => '/blog'
			})
	end
	files = Dir.glob("pages/*")
	files.each do |file|
		file_contents = File.read(file)
		unless File.basename(file) == "index.md"
			begin
				if (markdown = file_contents.match(/^(?<headers>---\s*\n.*?\n?)^(---\s*$\n?)/m))
					article = markdown.post_match
					metadata = YAML.load(markdown[:headers])
					pages.push({
						:filename => File.basename(file, '.*'),
						:title => metadata['title'],
						:slug => "/"+metadata['slug']
						})
				end
			rescue => e
				puts "YAML Exception reading #{file}: #{e.message}"
			end
		end
	end

	File.open('./views/shared/nav.haml', 'w+'){ |f|
		f.write("%nav\n\t%ul\n")
		pages.each do |page|
			f.write("\t\t%li\n\t\t\t%a{:href=>'" + page[:slug] + "'} " + page[:title] + "\n")
		end
	}
	File.open('_page-index.yaml', 'w+'){ |f|
		f.write pages.ya2yaml
	}
end

task :generate_post_index do
	puts "Indexing Blog Entries..."
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
					:author => metadata['author'],
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

task :new_page do
	title = get_stdin("Enter a title for your new page: ")
	filename = "./pages/#{title.to_url}.md"
	puts "Creating new page: #{filename}"
	File.open(filename, 'w+') do |page|
		page.puts("---")
		page.puts("title: #{title}")
		page.puts("date: #{Time.now.strftime('%Y-%m-%d %H:%M')}")
		page.puts("slug: #{title.to_url}")
		page.puts("author: #{default_author}")
		page.puts("---")
	end
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
		post.puts("author: #{default_author}")
		post.puts("---")
	end
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end