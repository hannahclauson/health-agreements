class CompaniesController < ApplicationController
  def new
  end

  def create
    @company = Company.new(params.require(:company).permit(
                                                           :name,
                                                           :description,
                                                           :url
                                                           )
                           )
    @company.save
    redirect_to @company
  end
end
