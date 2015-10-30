class Practice < ActiveRecord::Base
  include Implementation

  belongs_to :guideline
  belongs_to :company

  after_create :check_badge_eligibility
  after_update :check_badge_eligibility
  after_destroy :remove_related_awards

  # should also validate its in the expected range
  # and should really not expose the integers to the user for now but have a select input instead

  validates :guideline, presence: true
  validates_uniqueness_of :guideline_id, :scope => [:company_id, :company]

  def remove_related_awards
    related_badges = guideline.badge_practices.where(:guideline_id => guideline.id).pluck(:badge_id)
    company.badge_awards.where(:badge_id => related_badges).destroy_all
  end


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

  def normalized_name
    self.name.split(" ").collect {|w| w.capitalize}.join(" ")
  end

end
