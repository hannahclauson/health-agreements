class Contribution < ActiveRecord::Base
  validates :url, presence: false, uniqueness: true
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}
end
