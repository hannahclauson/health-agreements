class PracticesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @practices = @company.practices
  end

  def create
    @company = Company.find(params[:company_id])
    @practice = @company.practices.create(allowed_params)

    if @practice.save
      redirect_to company_path(@company)
    else
      render 'edit'
    end
  end

  def show
    @practice = Practice.find(params[:id])
    # Dont seem to need to eager load just to access
    #Practice.includes(:company).find(params[:id])
    # To determine if I just cannot see this in the view, I'll play w assoc objs here
    @c = @practice.company
    @g = @practice.guideline

  end

  def edit
    @practice = Practice.find(params[:id])
    @company = @practice.company # Syntactic sugar to let me reuse the form partial
  end

  def update
    @practice = Practice.find(params[:id])

    if @practice.update(allowed_params)
      redirect_to @practice.company
    else
      @company = @practice.company
      render 'edit'
    end
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
    params.require(:practice).permit(:implementation, :notes, :guideline_id)
  end
end
