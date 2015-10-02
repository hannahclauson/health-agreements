class BadgePractice < ActiveRecord::Base
  include Implementation
  belongs_to :guideline
  belongs_to :badge

  after_create :mark_rebuild_needed
  after_destroy :mark_rebuild_needed

  def mark_rebuild_needed
    puts "BAdge needs to be rebuilt"
    badge.needs_to_rebuild = true
    badge.save!
  end

end
