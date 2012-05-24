require "sinatra/base"

module Church
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
      haml :messages
    end

    get "/small_groups.html" do
      haml :small_groups
    end
  end
end
