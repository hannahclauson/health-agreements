class Article < ActiveRecord::Base
  belongs_to :journal
  belongs_to :company

  validates :title, presence: true, length: {minimum: 10}, uniqueness: true

  validates :summary_url, presence: true, uniqueness: true
  validates :summary_url, format: {with: URI.regexp }, if: Proc.new {|a| a.summary_url.present?}

  validates :download_url, format: {with: URI.regexp }, if: Proc.new {|a| a.download_url.present?}

end
