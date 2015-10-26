require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @company = create(:company)
    @article = create(:article, company: @company)
    @other_article = create(:article)

    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Helper for testing access_denied
  def access_denied
    request.env["HTTP_REFERER"] = companies_path
    yield
    assert_redirected_to root_path
    assert_equal "You are not authorized to access this page.", flash[:alert]
  end

  test "should get index" do
    get :index, company_id: @article.company
    assert_response :success
    assert_equal 2, assigns(:articles).size
  end

  test "should get show" do
    get "show", company_id: @article.company, :id => @article
    assert_response :success
    assert_not_nil assigns(:article)
  end

  # Test editor access actions w neg controls

  test "should not get edit" do
    access_denied do
      get :edit, company_id: @article.company, id: @article
    end
  end

  test "should get edit" do
    sign_in @editor
    get :edit, company_id: @article.company, id: @article
    assert_response :success
    assert_not_nil assigns(:article)
  end

  test "should not update" do
    access_denied do
      post :update, company_id: @article.company, id: @article, article: {title: 'acmezzzz'}
    end
  end

  test "should update" do
    sign_in @editor
    post :update, company_id: @article.company, id: @article, article: {title: 'acmezzzz'}
    assert_redirected_to article_path(assigns[:article])
    assert_equal "acmezzzz", assigns(:article).title
    assert_equal @article.url, assigns(:article).url
  end

  test "should not get new" do
    access_denied do
      get :new
    end
  end

  test "should get new" do
    sign_in @editor
    get :new
    assert_response :success
  end

  test "should not create" do
    access_denied do
      post :create, article: {
        title: 'acme corporation LLC',
        summary_url: 'http://acme.com',
        download_url: 'http://acme.com/papers/1.pdf'
      }
    end
  end

  test "should create" do
    sign_in @editor
    post :create, article: {title: 'acme corporation LLC', summary_url: 'http://acme.com'}
    assert_redirected_to article_path(assigns[:article])
  end

  test "should not delete (anon user)" do
    count = Article.all.size

    access_denied do
      delete :destroy, company_id: @article.company, id: @article.id
    end

    assert_equal count, Article.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = Article.all.size

    access_denied do
      delete :destroy, company_id: @article.company, id: @article.id
    end

    assert_equal count, Article.all.size
  end

  test "should delete" do
    sign_in @admin
    count = Article.all.size
    request.env["HTTP_REFERER"] = articles_path

    delete :destroy, company_id: @article.company, id: @other_article

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to articles_path
    assert_equal count-1, Article.all.size
  end


end
