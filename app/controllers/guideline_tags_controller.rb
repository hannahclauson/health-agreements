class GuidelineTagsController < ApplicationController

  def index
    authorize! :index, GuidelineTag
    @guideline_tags = GuidelineTag.all
  end

  def new
    authorize! :new, GuidelineTag
    @guideline_tag = GuidelineTag.new
  end

  def create
    authorize! :create, GuidelineTag
    @guideline_tag = GuidelineTag.create(allowed_params)

    if @guideline_tag.save
      flash[:notice] = "Successfully saved new guideline tag #{@guideline_tag.name}"
      redirect_to guideline_tags_path
    else
      render 'new'
    end
  end

  def destroy
    current_guideline_tag
    @guideline_tag.destroy

    redirect_to guideline_tags_path

  end

  private

  def current_guideline_tag
    @guideline_tag ||= GuidelineTag.where(slug: params[:id]).first
    authorize! action_name.to_sym, @guideline_tag
  end

  def allowed_params
    params.require(:guideline_tag).permit(:name)
  end

end
