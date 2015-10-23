class CompaniesController < ApplicationController

  autocomplete :archetype, :name, :extra_data => [:id]
  autocomplete :company, :name
  autocomplete :guideline, :name, :extra_data => [:id]
  # implementation autocomplete lives in practices_controller

  def new
    authorize! :new, Company
    @company = Company.new
  end

  def edit
    current_company
  end

  def update
    current_company

    if @company.update(company_params)
      redirect_to @company
    else
      render 'edit'
    end
  end

  def index
    c = Company.all

    @errors = []

    if params[:company].present?
      c = c.filter_name(params[:company][:name]) if params[:company][:name].present?
    end

    if params[:archetype].present?
      c = c.filter_badges(params[:archetype][:id]) if params[:archetype][:id].present?
    end

    if params[:guideline].present?
      if params[:guideline][:id].present? & params[:practice][:implementation].present?
        c = c.filter_practices(params[:guideline][:id], params[:practice][:implementation])
      end

      if params[:guideline][:id].present? ^ params[:practice][:implementation].present?
        @errors << {
          :message => "Must specify both guideline and implementation."
        }
      end
    end

    @searched = (params[:commit] == 'Search')

    @companies = c

    redirect_to @companies.first if @companies.size == 1

  end


  def create
    authorize! :create, Company
    @company = Company.create(company_params)

    if @company.save
      redirect_to @company
    else
      render 'new'
    end
  end

  def show
    current_company
    @practice = Practice.new
  end

  def destroy
    current_company
    @company.destroy

    redirect_to companies_path

 end

  private

  def current_company
    @company ||= Company.where(slug: params[:id]).first
    authorize! action_name.to_sym, @company
  end

  def company_params
    params.require(:company).permit(
                                    :name,
                                    :description,
                                    :url
                                    )
  end

end
