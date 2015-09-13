class CompaniesController < ApplicationController
  autocomplete :archetype, :name
  autocomplete :guideline, :name
  autocomplete :company, :name

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to @company
    else
      render 'edit'
    end
  end

  def index
    @companies = Company.all

    @companies = @companies.filter_name(params[:name]) if params[:name].present?
    @companies = @companies.filter_badges(params[:archetype_id]) if params[:archetype_id].present?

#    if params[:search]
#      @companies = Company.search(params[:search]).order("created_at DESC")
#    end

  end


  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to @company

    else
      render 'new'
    end
  end

  def show
    @company = Company.find(params[:id])
    @parent = @company # syntactic sugar so I can reuse the practices form partial
    @practice = Practice.new
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to companies_path
 
 end

  private

  def company_params
    params.require(:company).permit(
                                    :name,
                                    :description,
                                    :url
                                    )
  end

end
