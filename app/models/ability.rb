class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :show, :index, :to => :view
    alias_action :create, :update, :to => :mutate

    # Omits users / registrations / etc
    # Also shouldn't have direct access to badge_awards

    site_objects = [
      Company,
      Practice,
      Guideline,
      Badge,
      BadgePractice
    ]

    can :view, site_objects

    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :mutate, site_objects
    end

  end
end
