class CompaniesController < ApplicationController
  autocomplete :archetype, :name, :extra_data => [:id]
  autocomplete :company, :name
  autocomplete :guideline, :name, :extra_data => [:id]
  # implementation autocomplete lives in practices_controller

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
    c = Company.all

    @errors = []

    c = c.filter_name(params[:company][:name]) if params[:company][:name].present?

    c = c.filter_badges(params[:archetype][:id]) if params[:archetype][:id].present?

    if params[:guideline][:id].present? & params[:practice][:implementation].present?
      c = c.filter_practices(params[:guideline][:id], params[:practice][:implementation])
    end

    if params[:guideline][:id].present? ^ params[:practice][:implementation].present?
      @errors << {
        :message => "Must specify both guideline and implementation."
      }
    end

    @searched = params[:commit] == 'Search'

    @companies = c

    redirect_to @companies.first if @companies.size == 1

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
