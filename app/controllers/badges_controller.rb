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
    current_badge
  end

  def show
    current_badge
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
    current_badge

    if @badge.update(allowed_params)
      redirect_to @badge
    else
      render 'edit'
    end
  end

  def rebuild
    current_badge
    @companies = @badge.rebuild_awards!.delete(nil)
    @companies = [] if @companies.nil?

    render 'rebuilt', notice: "Successfully Rebuilt Badge"
  end

  def destroy
    @badge.destroy
    redirect_to badges_path
  end

  private

  def current_badge
    @badge ||= Badge.find(params[:id])
  end

  def allowed_params
    params.require(:badge).permit(:name, :description, :badge_practices_attributes => [:implementation, :guideline_id])
  end

end
