class Company < ActiveRecord::Base
  has_many :practices, as: :practiceable, dependent: :destroy
  accepts_nested_attributes_for :practices
  has_many :badges, dependent: :destroy

  validates :name, presence: true, length: {minimum: 3}
  validates :url, presence: true
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}


  scope :filter_name, -> (name) {
    where("name ILIKE ?", name)
  }

  scope :filter_badges, -> (archetype_id) {
    includes(:badges).where("badges.archetype_id = ?", archetype_id).references(:badges)
  }

  scope :filter_practices, -> (guideline_id, implementation) {
    includes(:practices).where("practices.guideline_id = ?", guideline_id).where("practices.implementation = ?", implementation).references(:practices)
  }

end
