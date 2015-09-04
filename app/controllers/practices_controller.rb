class PracticesController < ApplicationController
  def create
    @practice = Practice.new(allowed_params)

    if @practice.save
      redirect_to practice_path(@practice)
    else
      render 'new'
    end
  end

  private

  def allowed_params
    # need to whitelist foreign_id for guideline? and owner company?
    params.require(:practice).permit(:implementation, :notes)
  end
end
