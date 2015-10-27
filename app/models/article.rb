class Article < ActiveRecord::Base
  belongs_to :journal
  belongs_to :company

  validates :title, presence: true, length: {minimum: 10}, uniqueness: true

  validates :summary_url, presence: true, uniqueness: true
  validates :summary_url, format: {with: URI.regexp }, if: Proc.new {|a| a.summary_url.present?}

  validates :download_url, format: {with: URI.regexp }, if: Proc.new {|a| a.download_url.present?}

  after_create :update_company_impact_factor
  after_update :update_company_impact_factor
  after_destroy :update_company_impact_factor

  def update_company_impact_factor
    self.company.update_impact_factor
  end

end
