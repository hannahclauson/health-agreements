class CompaniesController < ApplicationController
  def new
  end

  def create
    @company = Company.new(article_params)
    @company.save
    redirect_to @company
  end

  def show
    @company = Company.find(params[:id])
  end

  private

  def article_params
    params.require(:company).permit(
                                    :name,
                                    :description,
                                    :url
                                    )
  end

end
