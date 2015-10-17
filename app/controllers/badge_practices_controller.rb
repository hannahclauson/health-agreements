class BadgePracticesController < ApplicationController

  def create
    current_badge
    authorize! :create, BadgePractice
    @badge_practice = @badge.badge_practices.create(badge_practice_params)
    if @badge_practice.save
      redirect_to badge_path(@badge)
    else
      render 'badges/show'
    end
  end

  def destroy
    # Need to skip badge auth. The only auth requirement is :delete on BadgePractice
    @badge = Badge.where( slug: params[:badge_id] ).first

    current_badge_practice

    @badge_practice.destroy
    redirect_to badge_path(@badge)
  end

 private

  def current_badge
    @badge ||= Badge.where( slug: params[:badge_id] ).first
    authorize! action_name.to_sym, @badge
  end

  def current_badge_practice
    @badge_practice ||= @badge.badge_practices.find(params[:id])
    authorize! action_name.to_sym, @badge_practice
  end

  def badge_practice_params
    params.require('badge_practice').permit(:implementation, :guideline_id)
  end
end
