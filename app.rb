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

get "/:page" do
	@page_content = RDiscount.new(File.open("pages/" + params["page"] + ".md").read).to_html
	page_title = Nokogiri::HTML::DocumentFragment.parse(@page_content).css('h1').inner_html()
	@title = "#{page_title} &mdash; Adam James Clarkson"
	haml :page
end