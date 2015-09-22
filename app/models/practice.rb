class Practice < ActiveRecord::Base
  include Implementation

  belongs_to :guideline
  belongs_to :company

  # should also validate its in the expected range
  # and should really not expose the integers to the user for now but have a select input instead

  validates :guideline, presence: true

end
