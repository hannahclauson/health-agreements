# BADGE ARCHITECT
class Badge < ActiveRecord::Base
  has_many :badge_practices, dependent: :destroy
  has_many :badge_awards, dependent: :destroy
  accepts_nested_attributes_for :badge_practices

  before_save :generate_slug

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def check(company)
    badge_practices.all? do |badge_practice|
      company.practices.where(:guideline_id => badge_practice.guideline_id,
                              :implementation => badge_practice.implementation).any?
    end
  end

  def check_and_award(company)
    # Remove the badge award
    award = company.badge_awards.where(:badge_id => self.id).first
    award.destroy unless award.nil?

    # Add badge award if company still adheres to the practices
    if check(company)
      badge_awards.create(company: company)
      return company.slug #collect the names of companies w newly awarded badges
    end
  end

  # When this badge changes, check against all companies
  def rebuild_awards!
    badge_awards.destroy_all
    Company.all.collect do |company|
      check_and_award(company)
    end
  end

  # This should only be used when seeding
  # - rechecks all badges / all companies
  def self.rebuild_awards!
    Badge.all.each &:rebuild_awards!
  end

  def generate_slug
    self.slug = name.to_slug.normalize.to_s
  end
end
