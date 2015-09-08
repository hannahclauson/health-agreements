class ArchetypesController < ApplicationController
  def index
    @archetypes = Archetype.all
  end

  def new
    @archetype = Archetype.new
  end

  def show
    @archetype = Archetype.find(params[:id])
    @practice = Practice.new
  end

  def create
    @archetype = Archetype.new(allowed_params)

    if @archetype.save
      redirect_to @archetype
    else
      render 'new'
    end
  end

  private

  def allowed_params
    params.require(:archetype).permit(:name, :description)
  end

end
