class Practice < ActiveRecord::Base
  belongs_to :company
  belongs_to :guideline
end
