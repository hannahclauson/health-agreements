class Company < ActiveRecord::Base
  has_many :practices, dependent: :destroy
  accepts_nested_attributes_for :practices
  has_many :badge_awards, dependent: :destroy
  has_many :badges, through: :badge_awards

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

  scope :filter_practices, -> (guideline_id, implementation) {
    includes(:practices).where("practices.guideline_id = ?", guideline_id).where("practices.implementation = ?", implementation).references(:practices)
  }

  def generate_slug
    self.slug = name.to_slug.normalize.to_s
  end

  def to_param
    slug
  end

end
