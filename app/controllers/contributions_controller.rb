class ContributionsController < ApplicationController

  def new
    authorize! :create, Contribution
    @contribution = Contribution.new
  end

  def submissions
    authorize! :submissions, Contribution
    @contributions = Contribution.all
  end

  def create
    authorize! :create, Contribution
    @contribution = Contribution.create(allowed_params)

    if @contribution.save
      flash[:notice] = "Thank you for your #{allowed_params[:kind]} submission"
      redirect_to new_contribution_path
    else
      render 'new'
    end
  end

  private

  def allowed_params
    params.require(:contribution).permit(
                                    :kind,
                                    :url,
                                    :email
                                    )
  end


end
