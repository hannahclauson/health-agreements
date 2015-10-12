class Guideline < ActiveRecord::Base
  has_many :practices, dependent: :destroy
  has_many :badge_practices, dependent: :destroy
  has_many :badges, through: :badge_practices

  validates :name, presence: true, length: {minimum: 3}, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}
  validates :true_description, presence: true, length: {minimum: 10}
  validates :false_description, presence: true, length: {minimum: 10}
end
