require "bundler/setup"
require "sinatra/base"

require_relative "models/nlag"


class Application < Sinatra::Application
  ["/", "/index.html"].each do |path|
    get path do
      haml :index
    end
  end

  get "/about_us.html" do
    haml :about_us
  end

  get "/events.html" do
    haml :events
  end

  get "/messages.html" do
    password = params[:password] || ""
    correct_password = ENV["MESSAGES_PASSWORD"]
    @authorized = (password == correct_password and not correct_password.nil?)
    @failed_attempt = (not @authorized and not password.empty?)
    @sermon_list = Nlag::SermonList.new if @authorized
    haml :messages
  end

  get "/small_groups.html" do
    haml :small_groups
  end
end
