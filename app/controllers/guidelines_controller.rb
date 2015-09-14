require 'protected_controller'

class GuidelinesController < ProtectedController

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

  def edit
    @guideline = Guideline.find(params[:id])
  end

  def update
    @guideline = Guideline.find(params[:id])

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
    @guideline = Guideline.find(params[:id])
    @guideline.destroy

    redirect_to guidelines_path
  end

  private

  def guideline_params
    params.require(:guideline).permit(:name, :description, :true_description, :false_description)
  end
end
