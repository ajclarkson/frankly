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
	haml :post
end