class Ability
  include CanCan::Ability

  def initialize(user)
    puts "User - nil" if user.nil?
    user ||= User.new

    puts "User - editor" if user.editor?
    puts "User - admin" if user.admin?

    # If the user exists, they're an editor
    # Anon users (nil user) is general public

    alias_action :show, :index, :to => :view
    alias_action :new, :create, :edit, :update, :to => :mutate

    # Omits users / registrations / etc
    # Also shouldn't have direct access to badge_awards

    site_objects = [
      Company,
      Practice,
      Guideline,
      Badge
    ]

    can :view, site_objects

    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :mutate, site_objects
#      can :mutate, BadgePractice
#      can :delete, BadgePractice
    end


  end
end
