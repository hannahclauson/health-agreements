class ArticlesController < ApplicationController

  def show
    current_article
  end

  def index
    @articles = Article.all
  end

  def new
    authorize! :new, Article
    @article = Article.new
  end

  def create
    authorize! :create, Article
    @article = Article.create(article_params)

    if @article.save
      redirect_to company_article_path(@article.company, @article)
    else
      render 'new'
    end
  end

  def edit
    current_article
  end

  def update
    current_article

    if @article.update(article_params)
      redirect_to company_article_path(@article.company, @article)
    else
      render 'edit'
    end
  end

  def destroy
    current_article
    @article.destroy

    redirect_to articles_path
  end


  private

  def article_params
    params.require(:article).permit(
                                    :name,
                                    :impact_factor,
                                    :url
                                    )
  end

  def current_article
    @article ||= Article.find(params[:id])
    authorize! action_name.to_sym, Article
  end

end
