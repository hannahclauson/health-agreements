# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'yaml'
require ::File.expand_path('../../config/environment', __FILE__)

data = YAML.load(File.read('db/seeds.yaml'))

data['guidelines'].each do |g|
  Guideline.create(
                   name: g['name'],
                   description: g['description'],
                   true_description: g['true_description'],
                   false_description: g['false_description']
                   )
end


data['companies'].each do |c|

  new_c = Company.create(
                 name: c['name'],
                 url: c['url']
                 )

  normalized_practices = []
  c['practices'].each do |p|
    this_p = {}
    p.each do |k,v|
      this_p[k.to_sym] = v
    end
    this_p[:practiceable_id] = new_c.id
    puts "Creating practice from: #{this_p}"
    normalized_practices << this_p
  end

  new_c.update({:practices => Practice.create(normalized_practices)})

  puts "Created company?"
  puts new_c
  puts new_c.errors.full_messages.join("\n")

end



data['archetypes'].each do |a|

  new_a = Archetype.create(
                 name: a['name'],
                 description: a['description']
                 )

  normalized_practices = []
  a['practices'].each do |p|
    this_p = {}
    p.each do |k,v|
      this_p[k.to_sym] = v
    end
    this_p[:practiceable_id] = new_a.id
    puts "Creating practice from: #{this_p}"
    normalized_practices << this_p
  end

  new_a.update({:practices => Practice.create(normalized_practices)})

  puts "Created archetype?"
  puts new_a
  puts new_a.errors.full_messages.join("\n")

end

# Calculate Badges

ac = ApplicationController.new
ac.reevaluate_badges

# Create Admin

admin = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
  user.password = Rails.application.secrets.admin_password
  user.password_confirmation = Rails.application.secrets.admin_password
  user.admin!
  user.confirm
end

puts "Created admin : #{admin.email}"

