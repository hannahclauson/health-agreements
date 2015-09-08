class ArchetypesController < ApplicationController
  def index
    @archetypes = Archetype.all
  end

  def new
    
  end
end
