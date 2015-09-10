# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :estimate do
  desc "Estimate Time to Launch"
  task :launch => :environment do
    f = File.read("attack-plan.md")
    total = 0
    f.gsub(/\(\##\s*est\s([\d\.]*?)\s/) do |match|
      total += $1.to_i unless $1.nil?
    end

    puts "#{total} days left until launch"
  end


end
