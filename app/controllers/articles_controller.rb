class ArticlesController < ApplicationController

  def show
    current_company
    current_article
  end

  def index
    current_company
    @articles = Article.all
  end

  def create
    current_company

    authorize! :create, Article
    @article = @company.articles.create(article_params)

    if @article.save
      redirect_to company_path(@article.company)
    else
      render 'edit'
    end
  end

  def edit
    current_company
    current_article
  end

  def update
    current_company
    current_article

    if @article.update(article_params)
      redirect_to company_article_path(@article.company, @article)
    else
      render 'edit'
    end
  end

  def destroy
    current_company
    current_article
    @article.destroy
    redirect_to company_path(@company)
  end


  private

  def article_params
    params.require(:article).permit(
                                    :title,
                                    :summary_url,
                                    :download_url,
                                    :journal_id
                                    )
  end

  def current_company
    @company ||= Company.where(slug: params[:company_id]).first
    authorize! action_name.to_sym, @company
  end

  def current_article
    @article ||= Article.find(params[:id])
    authorize! action_name.to_sym, Article
  end

end
