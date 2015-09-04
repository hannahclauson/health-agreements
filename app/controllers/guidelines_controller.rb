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
    @guideline = Guideline.find(params[:id])
  end

  private

  def guideline_params
    params.require(:guideline).permit(:name, :description, :true_description, :false_description)
  end
end
