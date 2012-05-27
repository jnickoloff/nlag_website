require_relative "../../app.rb"

require "capybara/cucumber"
require "rspec/expectations"

ENV["RACK_ENV"] = "test"

class MyWorld
  Capybara.app = Application
end

World{MyWorld.new}
