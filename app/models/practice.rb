class Practice < ActiveRecord::Base
  belongs_to :company
  belongs_to :guideline

  validates :implementation, presence: true
  # should also validate its in the expected range
  # and should really not expose the integers to the user for now but have a select input instead

  IMPLEMENTATION_MAP = {
    1 => :follows,
    2 => :does_not_follow,
    3 => :na,
    4 => :ambiguous
  }

  def implementation_text
    # Displays current implementation as text
    Practice::IMPLEMENTATION_MAP[self.implementation]
  end

end


