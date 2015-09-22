# BADGE ARCHITECT
class Badge < ActiveRecord::Base
  has_many :badge_practices
  has_many :badge_awards, dependent: :destroy
  accepts_nested_attributes_for :badge_practices

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
