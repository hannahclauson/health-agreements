class Badge < ActiveRecord::Base
  belongs_to :company
  belongs_to :archetype
end
