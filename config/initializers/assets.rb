# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

puts "APPLICATION CONFIG"
puts Rails.application.config
puts Rails.application.config.assets

%w( application archetypes companies documents guidelines practices welcome ).each do |controller|
  value = ["#{controller}.js.coffee", "#{controller}.css"]
  puts "ADDING CONTROLLER ASSETS"
  puts value
  Rails.application.config.assets.precompile += value
end
