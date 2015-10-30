class Journal < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :companies, through: :articles

  before_save :generate_slug

  validates :name, presence: true, length: {minimum: 3}, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}
  validates :impact_factor, presence: true

  after_update :update_company_impact_factor
  after_destroy :update_company_impact_factor

  def update_company_impact_factor
    self.companies.each do |c|
      c.update_impact_factor
    end
  end

  def normalized_name
    self.name.split(" ").collect {|w| w.capitalize}.join(" ")
  end

  def generate_slug
    self.slug = name.to_slug.normalize.to_s
  end

  def to_param
    slug
  end

end
