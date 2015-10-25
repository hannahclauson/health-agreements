class ArticlesController < ApplicationController

  def show
    current_article
  end

  private

  def current_article
    @article ||= Article.find(params[:id])
    authorize! action_name.to_sym, Article
  end

end
