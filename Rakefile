## Site Configuration Variables

show_home_link	=	true	#Should an automatically generated 'Home' link be added to site navigation





##### DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU"RE DOING! 

require 'rubygems'
require 'bundler/setup'

desc "Generate Page Navigation"
task :Generate do 
	pages = []
	pages.push("%nav\n\t%ul\n")
	if show_home_link
		pages.push("\t\t%li\n\t\t\t%a{:href => '/'} Home\n")
	end
	Dir['pages/*'].map { |p| page = File.basename(p, '.*')
		pages.push("\t\t%li\n\t\t\t%a{:href => '"+ page + "'} " + page + "\n")
	}
	File.open('views/shared/nav.haml', 'w') {
		|f| f.write(pages)
	}
end 