class CompaniesController < ApplicationController

  autocomplete :badge, :name, :extra_data => [:id]
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


  def empty_params?
    # return true if all params are empty

    [[:company,:name], [:badge, :id], [:guideline,:id], [:practice,:implementation]].each do |pair|
      next if params[pair.first].nil?

      param = params[pair.first][pair.last]
      if param.present? && param.size > 0
        return false
      end

    end

    true
  end

  def compare

    authorize! :compare, Company

    @a = Company.where(slug: params[:a]).first
    @b = Company.where(slug: params[:b]).first

    if @a.nil? || @b.nil?
      flash[:alert] = "Missing company to compare"
      redirect_to :back
      return
    end

    if @a == @b
      flash[:alert] = "Cannot compare to self"
      redirect_to @a
      return
    end

    @a_badges = {}
    @a.badges.each do |b|
      @a_badges[b.name] = b
    end

    @b_badges = {}
    @b.badges.each do |b|
      @b_badges[b.name] = b
    end

    @all_badge_names = [@a_badges.keys, @b_badges.keys].flatten(1).uniq.sort


    @all_guideline_ids = [@a.guidelines.pluck(:id, :name), @b.guidelines.pluck(:id, :name)].flatten(1).uniq

    @a_practices = {}
    @a.practices.each do |p|
      @a_practices[p.guideline.id] = p.implementation_text
    end

    @b_practices = {}
    @b.practices.each do |p|
      @b_practices[p.guideline.id] = p.implementation_text
    end

  end

  def index
    @impact_factor_sort = nil
    @name_sort = nil

    c = []

    if params[:impact_factor_sort].present?
      @impact_factor_sort = (params[:impact_factor_sort] == "desc") ? :desc : :asc
      a = Company.where("impact_factor is not null").order(impact_factor: @impact_factor_sort)
      b = Company.where("impact_factor is null")
      c = a + b
    elsif params[:name_sort].present?
      @name_sort = params[:name_sort] == "desc" ? :desc : :asc
      c = Company.all.order(name: @name_sort)
    else
      c = Company.all.order(:name)
    end

    @errors = []

    if params[:company].present?
      c = c.filter_name(params[:company][:name]) if params[:company][:name].present?
    end

    if params[:badge].present?
      c = c.filter_badges(params[:badge][:id]) if params[:badge][:id].present?
    end

    if params[:guideline].present?
      if params[:guideline][:id].present?
        if params[:practice][:implementation].present?
          c = c.filter_practices_by_name_and_impl(params[:guideline][:id], params[:practice][:implementation])
        else
          c = c.filter_practices_by_name(params[:guideline][:id])
        end
      end

      if params[:practice][:implementation].present? && !params[:guideline][:id].present?
        @errors << {
          :message => "If you specify implementation, you must specify a practice name."
        }
      end
    end

    @searched = (params[:commit] == 'Search')

    if @searched && empty_params?
      @errors << {
        :message => "Empty search. Please provide a search term"
      }
    end

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
