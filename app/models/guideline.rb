class Guideline < ActiveRecord::Base
  has_many :practices

  validates :name, presence: true, length: {minimum: 3}
  validates :description, presence: true, length: {minimum: 10}
  validates :true_description, presence: true, length: {minimum: 10}
  validates :false_description, presence: true, length: {minimum: 10}
end
