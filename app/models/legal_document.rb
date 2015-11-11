class LegalDocument < ActiveRecord::Base

  belongs_to :company

  validates :name, presence: true, length: {minimum: 3}, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}

end

