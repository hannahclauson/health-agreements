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

  def show
    @practice = Practice.includes(:company).find(params[:id])
    # To determine if I just cannot see this in the view, I'll play w assoc objs here
    @c = @practice.company
    @g = @practice.guideline
    

  end

  def destroy
    @practice = Practice.find(params[:id])
    company = @practice.company
    @practice.destroy

    redirect_to company
  end

  private

  def allowed_params
    # need to whitelist foreign_id for guideline? and owner company?
    params.require(:practice).permit(:implementation, :notes)
  end
end
