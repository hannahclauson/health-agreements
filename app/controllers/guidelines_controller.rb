require 'protected_controller'

class GuidelinesController < ApplicationController

  def new
    @guideline = Guideline.new
  end

  def create
    @guideline = Guideline.new(guideline_params)

    if @guideline.save
      redirect_to @guideline
    else
      render 'new'
    end
  end

  def show
    current_guideline
  end

  def edit
    current_guideline
  end

  def update
    current_guideline

    if @guideline.update(guideline_params)
      redirect_to @guideline
    else
      render 'edit'
    end
  end

  def index
    @guidelines = Guideline.all
  end

  def destroy
    current_guideline
    @guideline.destroy

    redirect_to guidelines_path
  end

  private

  def current_guideline
    @guideline ||= Guideline.find(params[:id])
  end
  helper_method :current_guideline

  def guideline_params
    params.require(:guideline).permit(:name, :description, :true_description, :false_description)
  end
end
