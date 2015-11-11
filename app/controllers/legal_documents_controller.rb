class LegalDocumentsController < ApplicationController

  def create
    current_company
    authorize! :create, Practice
    @legal_document = @company.legal_documents.create(allowed_params)

    if @legal_document.save
      redirect_to company_path(@company)
    else
      render 'edit'
    end
  end

  def edit
    current_company
    current_legal_document
  end

  def update
    current_company
    current_legal_document

    if @legal_document.update(allowed_params)
      redirect_to @company
    else
      render 'edit'
    end
  end

  def destroy
    current_company

    current_legal_document
    @legal_document.destroy

    redirect_to @company
  end

  private

  def allowed_params
    params.require(:legal_document).permit(:name, :url, :company_id)
  end

  def current_company
    @company ||= Company.where(slug: params[:company_id]).first
    authorize! action_name.to_sym, @company
  end

  def current_legal_document
    @legal_document ||= @company.legal_documents.find(params[:id])
    authorize! action_name.to_sym, @legal_documents
  end

end
