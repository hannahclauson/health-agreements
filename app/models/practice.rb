class Practice < ActiveRecord::Base
  belongs_to :guideline
  belongs_to :practiceable, polymorphic: true # either :company or :archetype

  validates :implementation, presence: true
  # should also validate its in the expected range
  # and should really not expose the integers to the user for now but have a select input instead

  validates :guideline, presence: true
  validates :practiceable, presence: true

  IMPLEMENTATION_MAP = {
    1 => :follows,
    2 => :does_not_follow,
    3 => :na,
    4 => :ambiguous,
    5 => :unknown
  }

  IMPLEMENTATION_DESC = {
    :follows => :true_description,
    :does_not_follow => :false_description
  }

  def implementation_text
    # Displays current implementation as text
    Practice::IMPLEMENTATION_MAP[self.implementation]
  end

  def implementation_description
    self.guideline[Practice::IMPLEMENTATION_DESC[implementation_text]]
  end

end


