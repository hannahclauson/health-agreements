require 'protected_controller'

class PracticesController < ProtectedController

  def index
    @company = Company.find(params[:company_id])
    @practices = @company.practices
  end

  def create
    @parent = polymorphic_parent
    @practice = @parent.practices.create(allowed_params)

    if @practice.save
      reevaluate_badges
      redirect_to polymorphic_path(@parent)
    else
      render 'edit'
    end
  end

  def show
    @practice = Practice.find(params[:id])

    # for individual practice show
    @parent = polymorphic_parent

    # syntactic sugar to reuse table partial (on company/arch show pages)
    @guideline = @practice.guideline 
    @description = @practice.implementation_description
  end

  def edit
    @practice = Practice.find(params[:id])
    @parent = @practice.practiceable
  end

  def update
    @practice = Practice.find(params[:id])
    @parent = @practice.practiceable

    if @practice.update(allowed_params)
      reevaluate_badges
      redirect_to @parent
    else
      @company = @parent
      render 'edit'
    end
  end

  def destroy
    @practice = Practice.find(params[:id])
    @parent = polymorphic_parent
    @practice.destroy

    reevaluate_badges

    redirect_to @parent
  end

  def autocomplete_implementations
    raw = view_context.enumerated_implementations
    opts = raw.collect do |pair|
      normalized_text = pair.first.to_s.split("_").join(" ").capitalize
      {
        :label => normalized_text,
        :value => normalized_text,
        :enumerated_value => pair.last,
        :id => pair.last
      }
    end
    render json: opts
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
