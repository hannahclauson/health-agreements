class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    type = "anon"
    type = "editor" if user.editor?
    type = "admin" if user.admin?
    puts "User - #{type}"

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
      Badge,
      BadgePractice
    ]

#    can :view, site_objects

    if user.admin?
#      can :manage, :all
    elsif user.editor?
#      can :mutate, site_objects
#      can :mutate, BadgePractice
#      can :delete, BadgePractice
    end


  end
end
