set :haml, :format => :html5
helpers do
  def render(*args)
    if args.first.is_a?(Hash) && args.first.keys.include?(:partial)
      return haml "#{args.first[:partial]}".to_sym, :layout => false
    else
      super
    end
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
end

get "/" do
	@page_content = RDiscount.new(File.open("pages/index.md").read).to_html
	@title = "Frankly" 
	haml :page
end

get "/blog" do
	@posts = YAML::load(File.open("_post-index.yaml"))
	@title = "Archive &mdash; Frankly"
	haml :blog
end

get "/:page" do
	@page_content = RDiscount.new(File.open("pages/" + params["page"] + ".md").read).to_html
	page_title = Nokogiri::HTML::DocumentFragment.parse(@page_content).css('h1').inner_html()
	@title = "#{page_title} &mdash; Frankly"
	haml :page
end

get "/blog/:post" do
	posts = YAML::load(File.open"_post-index.yaml")
	@post_meta = posts.find{|x| x[:slug] == "/blog/"+params[:post]}
	post_file_contents = File.read("posts/"+@post_meta[:filename]+".md")
	markdown = post_file_contents.match(/^(?<headers>---\s*\n.*?\n?)^(---\s*$\n?)/m)
	@post_title = @post_meta[:title]
	@post_content = RDiscount.new(markdown.post_match).to_html
	@title = "#{@post_title} &mdash; Frankly"
	haml :post
end