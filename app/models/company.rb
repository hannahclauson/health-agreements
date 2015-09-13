class Company < ActiveRecord::Base
  has_many :practices, as: :practiceable, dependent: :destroy
  accepts_nested_attributes_for :practices
  has_many :badges, dependent: :destroy

  validates :name, presence: true, length: {minimum: 3}
  validates :url, presence: true
  validates :url, format: {with: URI.regexp }, if: Proc.new {|a| a.url.present?}


  scope :filter_name, -> (name) {
    where("name ILIKE ?", "%#{name}%")
  }

  # Need to find if any of this company's badges have the associated archetype_id
  scope :filter_badges, -> (archetype_id) {
#Company.includes(:badges).where('badges.archetype_id = 1').references(:badges)
    includes(:badges).where("badges.archetype_id = ?", archetype_id).references(:badges)
  }

  def self.search(params)
    where("name ILIKE ?", "%#{params}")
  end
end
