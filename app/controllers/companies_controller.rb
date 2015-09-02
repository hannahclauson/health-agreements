class CompaniesController < ApplicationController
  def new
  end

  def create
    render plain: params[:company].inspect
  end
end
