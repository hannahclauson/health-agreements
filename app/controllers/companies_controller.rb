class CompaniesController < ApplicationController
  autocomplete :archetype, :name
  autocomplete :guideline, :name
  autocomplete :company, :name
  autocomplete :practice, :implementation, :display_value => :implementation_text

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
    c = c.filter_name(params[:name]) if params[:name].present?
    c = c.filter_badges(params[:archetype_id]) if params[:archetype_id].present?

    if params[:guideline_id].present? & params[:implementation].present?
      c = c.filter_practices(params[:guideline_id], params[:implementation])
    end

    @companies = c
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
