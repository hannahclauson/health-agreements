class Archetype < ActiveRecord::Base
  has_many :practices, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
