class BadgeAward < ActiveRecord::Base
  belongs_to :company
  belongs_to :badge
end
