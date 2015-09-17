class Archetype < ActiveRecord::Base
  has_many :practices, as: :practiceable, dependent: :destroy
  has_many :badges, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
