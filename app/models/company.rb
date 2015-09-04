class Company < ActiveRecord::Base
  has_many :practices
  accepts_nested_attributes_for :practices

  validates :name, presence: true, length: {minimum: 3}
  validates :url, presence: true
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}
end
