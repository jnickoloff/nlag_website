require "bundler/setup"
require "rspec/core/rake_task"
require "cucumber/rake/task"

task :default => [:spec, :cucumber]

RSpec::Core::RakeTask.new

Cucumber::Rake::Task.new do |task|
  task.cucumber_opts = ["#{ENV["FEATURE"]} --format #{ENV["FORMAT"] || "progress"}"]
end
