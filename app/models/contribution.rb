class Contribution < ActiveRecord::Base
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}
end
