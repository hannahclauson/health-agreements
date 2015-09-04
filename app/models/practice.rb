class Practice < ActiveRecord::Base
  belongs_to :company
  belongs_to :guideline

  validates :implements, presence: true
  # should also validate its in the expected range
  # and should really not expose the integers to the user for now but have a select input instead
end
