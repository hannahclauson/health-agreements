class BadgePracticesController < ProtectedController

  def create
    current_badge.badge_practices.create(badge_practice_params)
    redirect_to badge_path(current_badge)
  end

  def destroy
    current_badge_practice.destroy
    redirect_to badge_path(current_badge)
  end

 private
  def current_badge
    @badge ||= Badge.find(params[:badge_id])
  end

  def current_badge_practice
    @badge_practice ||= current_badge.badge_practices.find(params[:id])
  end

  def badge_practice_params
    params.require('badge_practice').permit(:implementation, :guideline_id)
  end
end
