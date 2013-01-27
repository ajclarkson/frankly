require 'open-uri'
set :haml, :format => :html5
helpers do
  def render(*args)
    if args.first.is_a?(Hash) && args.first.keys.include?(:partial)
      return haml "#{args.first[:partial]}".to_sym, :layout => false
    else
      super
    end
  end
  def return_base_title
    return "&mdash; Frankly"
  end
  def show_post_navigation(previous_name="Older", next_name="Newer")
  	nav_string = "<nav id='post-navigation' class='cf'>"
  	if @post_meta[:previous] != "" 
  		nav_string.concat("<div id='previous-navigation'><a href='"+@post_meta[:previous]+"'>"+ previous_name + "</a></div>")
  	end
  	if @post_meta[:next] != ""
  		nav_string.concat("<div id='next-navigation'><a href='"+@post_meta[:next]+"'>"+ next_name +"</a></div>")
  	end
  	return nav_string.concat("</nav>")
  end
  def show_post_date(format="%d/%m/%Y", post_meta=@post_meta)
  	return Time.parse(post_meta[:date]).strftime(format)
  end
  def show_latest_commit
    feed = open('https://github.com/ajclarkson/frankly/commits/master.atom') {|f| f.read }
    items = parse feed
    item = items.first
    return item[:title]

  end
  def parse feed
    doc = Nokogiri::XML feed
    doc.search('entry').map do |doc_entry|
      entry = { }
      entry[:title] = doc_entry.at('title').text
      entry
    end
  end
  
end

get "/" do
	@page_content = RDiscount.new(File.open("pages/index.md").read).to_html
	@title = "Frankly" 
	haml :page
end

get "/blog" do
	@posts = YAML::load(File.open("_post-index.yaml"))
	@title = "Archive #{return_base_title}"
	haml :blog
end

get "/rss.xml" do
  @posts = YAML::load(File.open("_post-index.yaml"))
  builder :rss
end

get "/:page" do
  pages = YAML::load(File.open"_page-index.yaml")
  @page_meta = pages.find{|x| x[:slug] == "/#{params[:page]}"}
  page_file_contents = File.read("pages/#{@page_meta[:filename]}.md")
  markdown = page_file_contents.match(/^(?<headers>---\s*\n.*?\n?)^(---\s*$\n?)/m)
  @page_title = @page_meta[:title]
  @page_content = RDiscount.new(markdown.post_match).to_html
	@title = "#{@page_title} #{return_base_title}"
	haml :page
end

get "/blog/:post" do
	posts = YAML::load(File.open"_post-index.yaml")
	@post_meta = posts.find{|x| x[:slug] == "/blog/"+params[:post]}
	post_file_contents = File.read("posts/"+@post_meta[:filename]+".md")
	markdown = post_file_contents.match(/^(?<headers>---\s*\n.*?\n?)^(---\s*$\n?)/m)
	@post_title = @post_meta[:title]
	@post_content = RDiscount.new(markdown.post_match).to_html
	@title = "#{@post_title} #{return_base_title}"
	haml :post
end