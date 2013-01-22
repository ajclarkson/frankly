xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do 
	xml.channel do
		@posts.each do |post|
			post_file_contents = File.read("./posts/"+post[:filename]+".md")
			markdown = post_file_contents.match(/^(?<headers>---\s*\n.*?\n?)^(---\s*$\n?)/m)
			xml.item do
				xml.title post[:title]
				xml.link "#{request.url.chomp request.path_info}#{post[:slug]}"
				xml.pubDate Time.parse(post[:date].to_s).rfc822
				xml.description RDiscount.new(markdown.post_match).to_html
			end
		end
	end
	
end