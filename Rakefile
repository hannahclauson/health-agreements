# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :estimate do
  desc "Estimate Time to Launch"
  task :launch => :environment do
    f = File.read("attack-plan.md")
    total = 0

    items = []

    f.gsub(/\-(.*?)\(\##\s*est\s([\d\.]*?)\s/) do |match|
      unless $2.nil?
        total += $2.to_i
        items << "#{$2} : #{$1}"
      end
    end

    puts "#{total} days left until launch"
    puts " * " + items.join("\n * ")
  end


end
