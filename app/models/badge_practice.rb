class BadgePractice < ActiveRecord::Base
  include Implementation
  belongs_to :guideline
  belongs_to :badge

  after_create :mark_rebuild_needed
  after_destroy :mark_rebuild_needed

  validates :guideline, presence: true
  validates_uniqueness_of :guideline_id, :scope => [:badge_id, :badge]

  def mark_rebuild_needed
    badge.needs_to_rebuild = true
    badge.save!
  end

end
