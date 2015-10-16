class Ability
  include CanCan::Ability

  def initialize(user)
    puts "input user is nil? #{user.nil?}"
    user ||= User.new

    puts "user: anon? #{user.anon?} editor? #{user.editor?} admin? #{user.admin?}"

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
      BadgeAward
    ]

    can :view, site_objects

    if user.admin?
      puts "user is admin"
      can :manage, :all
    elsif user.editor?
      puts "user is editor"
      can :mutate, site_objects
    end

  end
end
