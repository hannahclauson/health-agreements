class ContributionsController < ApplicationController

  def index
  end

  def create
    authorize! :create, Contribution
    @contribution = Contribution.create(allowed_params)

    if @contribution.save
      redirect_to contributions_path
    else
      render 'new'
    end
  end

  private

  def allowed_params
    params.require(:contribution).permit(
                                    :type,
                                    :url,
                                    :email
                                    )
  end


end
