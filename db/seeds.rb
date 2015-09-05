# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'yaml'

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
  normalized_practices = []
  c['practices'].each do |p|
    this_p = {}
    p.each do |k,v|
      this_p[k.to_sym] = v
    end
    normalized_practices << this_p
  end

  puts "raw pract #{c['practices']}"
  puts "norm pract #{normalized_practices}"

  p = Practice.create( c['practices'] )
  Company.create(
                 name: c['name'],
                 url: c['url'],
                 practices_attributes: normalized_practices
                 )
end
