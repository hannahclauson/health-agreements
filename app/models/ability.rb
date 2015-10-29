class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # If the user exists, they're an editor
    # Anon users (nil user) is general public

    alias_action :show, :index, :compare, :to => :view
    alias_action :new, :create, :edit, :update, :to => :mutate

    # Omits users / registrations / etc
    # Also shouldn't have direct access to badge_awards

    site_objects = [
      Company,
      Practice,
      Guideline,
      Badge,
      BadgePractice,
      Journal,
      Article
    ]

    can :view, site_objects

    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :mutate, site_objects
      can :rebuild, Badge
      can :manage, BadgePractice
    end

  end
end
