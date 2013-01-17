require 'rubygems'
require 'bundler/setup'

desc "Generate Page Navigation"
task :Generate do 
	pages = []
	pages.push("%nav\n\t%ul\n")
	pages.push("\t\t%li\n\t\t\t%a{:href => '/'} Home\n")
	Dir['pages/*'].map { |p| page = File.basename(p, '.*')
		pages.push("\t\t%li\n\t\t\t%a{:href => '"+ page + "'} " + page + "\n")
	}
	File.open('views/shared/nav.haml', 'w') {
		|f| f.write(pages)
	}
end 