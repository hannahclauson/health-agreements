class BadgePracticesController < ProtectedController

  def create
#    puts "Creating BP"
#    puts "checking current badge /auth"
#    current_badge
#    puts "done"
#    puts "checking current badge practice /auth"
#    authorize! :create, BadgePractice
#    puts "done"
#    @badge_practice = @badge.badge_practices.create(badge_practice_params)
#    redirect_to badge_path(@badge)
  end

  def destroy
    current_badge
    current_badge_practice

    @badge_practice.destroy
    redirect_to badge_path(@badge)
  end

 private

  def current_badge
    puts "can? #{action_name.to_sym} -> #{can? action_name.to_sym, @badge_practice}"
    @badge ||= Badge.where( slug: params[:badge_id] ).first
    authorize! action_name.to_sym, @badge
  end

  def current_badge_practice
    puts "can? #{action_name.to_sym} -> #{can? action_name.to_sym, @badge_practice}"
    @badge_practice ||= @badge.badge_practices.find(params[:id])
    authorize! action_name.to_sym, @badge_practice
  end

  def badge_practice_params
    params.require('badge_practice').permit(:implementation, :guideline_id)
  end
end
