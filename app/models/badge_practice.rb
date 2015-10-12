class BadgePractice < ActiveRecord::Base
  include Implementation
  belongs_to :guideline
  belongs_to :badge
end
