class PracticesController < ApplicationController

  def batch_new
    @company ||= Company.where(slug: params[:company_id]).first
    authorize! :new, @company

    authorize! :new, Practice
    raw_practices = @company.practices

    @errors_present = false
    @practices = {}
    raw_practices.each do |practice|
      @practices[practice.guideline.id] = practice
    end

    @tags = GuidelineTag.order(:name)

  end

  def batch_create
    @company ||= Company.where(slug: params[:company_id]).first
    authorize! :create, @company

    authorize! :create, Practice

    raw_practices = params["practices"]
    @practices = {}

    all_saved = true
    raw_practices.each do |raw_practice|
      next unless params["enabled"][raw_practice["guideline_id"].to_s] == "enabled"

      raw_practice = bulk_allowed_params(raw_practice)
      practice = @company.practices.create(raw_practice)

      if !practice.save
        all_saved = false
        @practices[practice.guideline.id] = practice
      end
    end

    @errors_present = !all_saved
    if all_saved
      redirect_to company_path(@company)
    else
      render 'batch_new'
    end

  end

  def create
    current_company

    authorize! :create, Practice
    @practice = @company.practices.create(allowed_params)

    if @practice.save
      redirect_to company_path(@company)
    else
      render 'edit'
    end
  end

  def show
    current_company
    current_practice

    # syntactic sugar to reuse table partial (on company/arch show pages)
    @guideline = @practice.guideline
    @description = @practice.notes
  end

  def edit
    current_company
    current_practice
  end

  def update
    current_company
    current_practice

    if @practice.update(allowed_params)
      redirect_to @company
    else
      render 'edit'
    end
  end

  def destroy
    current_company

    current_practice
    @practice.destroy

    redirect_to @company
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

  def bulk_allowed_params(p)
    p.permit(:implementation, :notes, :guideline_id, :legal_document_id)
  end

  def allowed_params
    params.require(:practice).permit(:implementation, :notes, :guideline_id, :legal_document_id)
  end

  def current_company
    @company ||= Company.where(slug: params[:company_id]).first
    authorize! action_name.to_sym, @company
  end

  def current_practice
    @practice ||= @company.practices.find(params[:id])
    authorize! action_name.to_sym, @practice
  end


end
