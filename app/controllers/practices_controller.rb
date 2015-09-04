class PracticesController < ApplicationController
  def create
    @company = Company.find(params[:company_id])
    @practice = @company.practices.create(allowed_params)

    if @practice.save
      redirect_to company_path(@company)
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
