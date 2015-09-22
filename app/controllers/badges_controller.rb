require 'protected_controller'

class BadgesController < ProtectedController

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
    @badge.badge_practices.build
  end

  def edit
    @badge = Badge.find(params[:id])
  end

  def show
    @badge = Badge.find(params[:id])
    @parent = @badge # syntactic sugar so I can reuse the practices form partial
    @practice = Practice.new
  end

  def create
    @badge = Badge.new(allowed_params)

    if @badge.save
      redirect_to @badge
    else
      render 'new'
    end
  end

  def update
    @badge = Badge.find(params[:id])

    if @badge.update(allowed_params)
      redirect_to @badge
    else
      render 'edit'
    end
  end

  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy
    redirect_to archetypes_path
  end

  private

  def allowed_params
    params.require(:badge).permit(:name, :description, :badge_practices_attributes => [:implementation, :guideline_id])
  end

end
