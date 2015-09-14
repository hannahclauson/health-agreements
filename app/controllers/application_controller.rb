require 'access_levels'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def page_type
    self.class.name.pluralize
  end

  before_action :editor_only, :except => AccessLevels::GLOBAL_ACTIONS
  before_action :admin_only, :except => [AccessLevels::GLOBAL_ACTIONS, AccessLevels::EDITOR_ACTIONS].flatten

  def editor_only
    if !self.view_context.editor_access_level?
      redirect_to :back, :alert => "Access Denied"
    end
  end

  def admin_only
    if !self.view_context.admin_access_level?
      redirect_to :back, :alert => "Access Denied"
    end
  end

  def reevaluate_badges

    # collect the ids / implementation as arrays for queries later
    arch_guidelines = {}

    # There should be relatively few of these ...
    # So load them all in mem?

    archetypes = Archetype.all.each do |a|
      arch_guidelines[a.id] = {}
      a.practices.find_each do |ap|
        arch_guidelines[a.id][ap.guideline_id] = ap.implementation
      end
    end

    puts "ARCH GUIDELINES"
    puts arch_guidelines

    # There are many companies. This is the loop that needs optimization

    Company.all.each do |c|
      puts "Checking company #{c.name} for badge eligibility"
      puts "-- has #{c.practices.size} practices to check"
      c_badges = c.badges

      archetypes.each do |a|

        # this many guidelines need to be met
        count = arch_guidelines[a.id].keys.size
        puts "NEED TO MEET #{count} guidelines"

        # Check company practices against guideline implementation
        # TODO - Probably want the outer loop here to be arch_practices since there will be much fewer of those than the company has practices

        puts "looking for comp practices that match arch guidelines"
        puts arch_guidelines[a.id].keys
        c_practices = c.practices.where(guideline_id: arch_guidelines[a.id].keys)
        puts "Found #{c_practices.size} practices on this company"
        c_practices.each do |cp|
          puts "Checking cp: #{cp}"
          puts "against ap: #{arch_guidelines[a.id][cp.guideline_id]}"

          if cp.implementation == arch_guidelines[a.id][cp.guideline_id]
            puts "Comp pract matches guideline!"
            puts "CP: #{cp}"
            puts "AP: #{arch_guidelines[a.id][cp.guideline_id]}"
            count -= 1
          end
        end

        if count == 0

          # All practices match. Add badge to company

          puts "All practices match!"
          b = Badge.new({:company => c, :archetype => a})
          c_badges << b

        else

          # Practices do not match. Make sure company does not have this badge

          puts "Some practices missing"
          c_badges.each do |b|
            if b.archetype_id == a.id
              c_badges.delete(b)
            end
          end

        end

      end

      # Update once per company
      # Need to figure out error handling ... if this fails, should probably accumulate errors
      c.update({:badges => c_badges})

    end

  end

end
