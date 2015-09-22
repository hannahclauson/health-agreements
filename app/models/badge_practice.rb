class BadgePractice < ActiveRecord::Base
  include Implementation

  belongs_to :badge
end
