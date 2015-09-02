class CompaniesController < ApplicationController
  def new
  end

  def index
    @companies = Company.all
  end

  def create
    @company = Company.new(article_params)
    if @company.save
      redirect_to @company
    else
      render 'new'
    end
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
