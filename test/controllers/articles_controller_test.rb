require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @company = create(:company)
    @journal = create(:journal, impact_factor: 10)
    @other_journal = create(:journal, impact_factor: 20)
    @article = create(:article, company: @company, journal: @journal)
    @other_article = create(:article, company: @company, journal: @journal)

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
    new_title = 'acmezzzz kljhsgkjhdsfgkljhdfgkjhdfkdfgldsfglkhdfgkjdsfg'
    post :update, company_id: @article.company, id: @article, article: {title: new_title}
    assert_redirected_to company_article_path(@article.company, assigns[:article])
    assert_equal new_title, assigns(:article).title
    assert_equal @article.summary_url, assigns(:article).summary_url
  end

  test "should company impact factor updated on article update" do
    sign_in @editor

    # should be updated in case the journal changes
    assert_equal 10, @company.impact_factor

    post :update, company_id: @article.company, id: @article, article: { journal: @other_journal}
    assert_redirected_to company_article_path(@article.company, assigns[:article])
    assert_equal 20, @company.impact_factor
  end

  test "should not create" do
    access_denied do
      post :create, company_id: @company, article: {
        title: 'acme corporation LLC',
        summary_url: 'http://acme.com',
        download_url: 'http://acme.com/papers/1.pdf'
      }
    end
  end

  test "should create" do
    sign_in @editor
    post :create, company_id: @company, article: {
      title: 'acme corporation LLC',
      summary_url: 'http://acme.com',
      journal: @journal,
      company: @company
    }
    assert_redirected_to company_path(@company)
  end

  test "should company impact factor updated on article create" do
    sign_in @editor
    ifactor = @company.impact_factor
    post :create, company_id: @company, article: {
      title: 'acme corporation LLC',
      summary_url: 'http://acme.com',
      journal: @other_journal,
      company: @company
    }
    assert_redirected_to company_path(@company)
    assert_equal 15, @company.impact_factor
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
    request.env["HTTP_REFERER"] = company_path(@company)

    delete :destroy, company_id: @article.company, id: @other_article

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to company_path(@company)
    assert_equal count-1, Article.all.size
  end

  test "should company impact factor updated on article delete" do
    sign_in @admin
    count = Article.all.size
    request.env["HTTP_REFERER"] = company_path(@company)

    assert_equal 10, @company.impact_factor

    delete :destroy, company_id: @article.company, id: @other_article

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to company_path(@company)
    assert_equal count-1, Article.all.size

    assert_equal nil, @company.impact_factor
  end


end
