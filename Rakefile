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

    f.split("\n").each do |line|

      line.gsub(/=+?.*?Milestone:(.*?)$/) do |match|
        milestone = $1
        puts "#{total} days left until #{milestone}"
        puts " * " + items.join("\n * ")      
        total = 0
        items = []
      end

      line.gsub(/\-(.*?)\(\##\s*est\s([\d\.]*?)\s/) do |match|
        unless $2.nil?
          total += $2.to_i
          items << "#{$2} : #{$1}"
        end
      end

    end

    puts "#{total} days left for remaining tasks"
    puts " * " + items.join("\n * ")


  end


end
