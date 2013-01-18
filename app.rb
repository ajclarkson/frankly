# app.rb
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
  	nav_string = ""
  	if @previous_article != "" 
  		nav_string.concat("<a href='"+@previous_article+"'>"+ previous_name + "</a>")
  	end

  	if @next_article != ""
  		nav_string.concat("<a href='"+@next_article+"'>"+ next_name +"</a>")
  	end
  	return nav_string
  end
end

get "/" do
	@page_content = RDiscount.new(File.open("pages/index.md").read).to_html
	@title = "Frankly" 
	haml :page
end

get "/blog" do
	@posts = YAML::load(File.open("_post-index.yaml"))
	haml :blog
end

get "/:page" do
	@page_content = RDiscount.new(File.open("pages/" + params["page"] + ".md").read).to_html
	page_title = Nokogiri::HTML::DocumentFragment.parse(@page_content).css('h1').inner_html()
	@title = "#{page_title} &mdash; Frankly"
	haml :page
end

get "/blog/:post" do
	@post_content = RDiscount.new(File.open("posts/"+ params["post"]+ ".md").read).to_html
	@posts = YAML::load(File.open("_post-index.yaml"))
	# @post_data = @posts.select{|p| p[:slug] == "/blog/"+params[:post]}
	# Not a ruby way?
	@posts.each do |blogpost|
		if blogpost[:slug] == "/blog/"+params["post"]
			@previous_article = blogpost[:previous]
			@next_article = blogpost[:next]
			puts "next" + @next_article
			puts "previous" + @previous_article
		end
	end
	haml :post
end