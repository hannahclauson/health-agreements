class PracticesController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
    @practices = @company.practices
  end

  def create
    @parent = polymorphic_parent
    @practice = @parent.practices.create(allowed_params)

    if @practice.save
      redirect_to polymorphic_path(@parent)
    else
      render 'edit'
    end
  end

  def show
    @practice = Practice.find(params[:id])
    @guideline = @practice.guideline # syntactic sugar to reuse table partial
    @description = @practice.implementation_description
  end

  def edit
    @practice = Practice.find(params[:id])
    @parent = @practice.practiceable
  end

  def update
    @practice = Practice.find(params[:id])

    if @practice.update(allowed_params)
      redirect_to @practice.company
    else
      @company = @practice.company
      render 'edit'
    end
  end

  def destroy
    @practice = Practice.find(params[:id])
    company = @practice.company
    @practice.destroy

    redirect_to company
  end

  private

  def allowed_params
    # need to whitelist foreign_id for guideline? and owner company?
    params.require(:practice).permit(:implementation, :notes, :guideline_id)
  end

  def polymorphic_parent
    request.path_parameters.each do |k, v|
      if k =~ /_id\z/
        parent_name = k.to_s.gsub(/_id\z/, "")
        return parent_name.classify.constantize.find(v)
      end
    end
  end

end
