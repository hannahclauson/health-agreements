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

data['badges'].each do |a|
  Badge.create(a).save!
end

data['companies'].each do |c|
  Company.create(c).save!
end

# Create Admin

admin = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
  user.password = Rails.application.secrets.admin_password
  user.password_confirmation = Rails.application.secrets.admin_password
  user.admin!
  user.confirm! # Need this for now for dev
end

puts "Created admin : #{admin.email}"
