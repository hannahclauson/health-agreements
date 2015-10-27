class Company < ActiveRecord::Base
  has_many :practices, dependent: :destroy
  accepts_nested_attributes_for :practices

  has_many :badge_awards, dependent: :destroy
  has_many :badges, through: :badge_awards

  has_many :articles, dependent: :destroy
  accepts_nested_attributes_for :articles

  has_many :journals, through: :articles

  before_save :generate_slug

  validates :name, presence: true, length: {minimum: 3}, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}
#  validates :practices, :uniqueness => {:scope => [:guideline_id]}
#  validates :practices, :practices_unique_on_guideline => true

  scope :filter_name, -> (name) {
    where("name ILIKE ?", "%#{name}%")
  }

  scope :filter_badges, -> (badge_id) {
    includes(:badge_awards).where("badge_awards.badge_id = ?", badge_id).references(:badge_awards)
  }

  scope :filter_practices_by_name, -> (guideline_id) {
    includes(:practices).where("practices.guideline_id = ?", guideline_id).references(:practices)
  }

  scope :filter_practices_by_name_and_impl, -> (guideline_id, implementation) {
    includes(:practices).where("practices.guideline_id = ?", guideline_id).where("practices.implementation = ?", implementation).references(:practices)
  }

  def update_impact_factor
    impact_factors = self.journals.pluck(:impact_factor)

    if impact_factors.size == 0
      self.impact_factor = nil
    end

    puts "Impact factors:"
    puts impact_factors

    sum = 0
    impact_factors.each {|a| sum += a}
    self.impact_factor = sum / impact_factors.size
  end

  def generate_slug
    self.slug = name.to_slug.normalize.to_s
  end

  def to_param
    slug
  end

end
