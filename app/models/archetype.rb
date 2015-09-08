class Archetype < ActiveRecord::Base
  has_many :practices, as: :practiceable, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
