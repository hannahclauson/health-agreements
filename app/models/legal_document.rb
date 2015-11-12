class LegalDocument < ActiveRecord::Base

  belongs_to :company

  validates :name, presence: true, length: {minimum: 3}
  validates :url, presence: true
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}

end

