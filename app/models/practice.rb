class Practice < ActiveRecord::Base
  include Implementation

  belongs_to :guideline
  belongs_to :company

  after_create :check_badge_eligibility

  # should also validate its in the expected range
  # and should really not expose the integers to the user for now but have a select input instead

  validates :guideline, presence: true

  def check_badge_eligibility
    guideline.badges.map do |badge|
      remaining_guidelines = badge.badge_practices.pluck(:guideline_id) - company.practices.pluck(:guideline_id)
      if remaining_guidelines.none?
        badge.check_and_award(company)
      else
        puts "Needs #{remaining_guidelines}"
      end
    end
  end

end
