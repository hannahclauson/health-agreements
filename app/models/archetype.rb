# BADGE ARCHITECT
class Archetype < ActiveRecord::Base
  has_many :practices, as: :practiceable, dependent: :destroy
  has_many :badges, dependent: :destroy
  accepts_nested_attributes_for :practices

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
