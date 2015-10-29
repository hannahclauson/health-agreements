require 'test_helper'
require 'json'

class CompaniesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @good_journal = create(:journal, impact_factor: 1000)
    @bad_journal = create(:journal, impact_factor: 1)

    @guideline = create(:guideline, name: 'zappa')
    @practice = create(:practice, guideline: @guideline)
    @company = create(:company, practices: [@practice], name: "AAAaaaaaa")

    @unique_company = create(:company, name: "ZZZZZZZZZZ")

    # For sorting tests
    @good_article = create(:article, company: @company, journal: @good_journal)
    @bad_article = create(:article, company: @unique_company, journal: @bad_journal)

    # so that most of the search tests dont return a single result and redirect
    p2 = create(:practice, guideline: @guideline)

    @very_similar_company = create(:company, practices: [p2])
    @very_similar_company.name = @company.name + "xx"
    @very_similar_company.save!

    # For searching by badge
    @badge = create(:badge, name: "Mad Science")
    ba1 = create(:badge_award, badge: @badge, company: @company)
    ba2 = create(:badge_award, badge: @badge, company: @very_similar_company)


    @other_company = create(:company)
    @editor = create(:user)
    @admin = create(:user, :admin)

  end

  # Actions that are publicly accessible

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get index sorted by impact_factor asc" do
    get :index, impact_factor_sort: "asc"

    assert_response :success
    assert_not_nil assigns(:companies)

    # Bcz companies w/o impact factors are appended, I verify by checking the opposite case
    # in this case -- that the first company is the one w the low impact factor
    assert_equal @unique_company.impact_factor, assigns[:companies].first.impact_factor
  end

  test "should get index sorted by impact_factor desc" do
    get :index, impact_factor_sort: "desc"

    assert_response :success
    assert_not_nil assigns(:companies)

    # Bcz companies w/o impact factors are appended, I verify by checking the opposite case
    # in this case -- that the first company is the one w the high impact factor
    assert_equal @company.impact_factor, assigns[:companies].first.impact_factor
  end

  test "should get index sorted by name asc" do
    get :index, name_sort: "asc"

    assert_response :success
    assert_not_nil assigns(:companies)

    assert_equal @company.name, assigns[:companies].first.name
  end

  test "should get index sorted by name desc" do
    get :index, name_sort: "desc"

    assert_response :success
    assert_not_nil assigns(:companies)

    assert_equal @unique_company.name, assigns[:companies].first.name
  end

  test "should show" do
    get :show, :id => @company.slug
    assert_response :success
    assert_not_nil assigns(:company)
  end

  # Search tests

  test "should report error when search is empty" do
    # test presence of ids -- since autocomplete should be populating those /
    # and those are what are actually used for searching
    get :index,
    "company" => {"name" => ""},
    "badge" => {"id" => ""},
    "guideline" => {"id" => ""},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_equal 1, assigns[:errors].size
    assert_equal "Empty search. Please provide a search term", assigns[:errors][0][:message]
  end

  test "should redirect w only one result" do
    get :index,
    "company" => {"name" => @unique_company.name},
    "badge" => {"id" => ""},
    "guideline" => {"id" => ""},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_redirected_to @unique_company
  end

  test "should search by name" do
    get :index,
    "company" => {"name" => @company.name},
    "badge" => {"id" => ""},
    "guideline" => {"id" => ""},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_response :success

    assert_equal 2, assigns[:companies].size
    assert_equal 0, assigns[:errors].size
  end

  test "should autocomplete by name" do
    get :autocomplete_company_name, "term" => @company.name[0..4]

    assert_response :success
    r = JSON.parse(response.body)
    assert_equal 2, r.size
  end

  test "should search by practice name" do
    get :index,
    "company" => {"name" => ""},
    "badge" => {"id" => ""},
    "guideline" => {"id" => @guideline.id},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_response :success

    assert_equal 2, assigns[:companies].size
    assert_equal 0, assigns[:errors].size
  end

  test "should not err when missing practice implementation" do
    get :index,
    "company" => {"name" => ""},
    "badge" => {"id" => ""},
    "guideline" => {"id" => @guideline.id},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_response :success
    assert_equal 0, assigns[:errors].size
  end

  test "should err when missing practice name" do
    get :index,
    "company" => {"name" => ""},
    "badge" => {"id" => ""},
    "guideline" => {"id" => ""},
    "practice" => {"implementation" => @practice.implementation},
    "commit" => "Search"

    assert_response :success
    assert_equal 1, assigns[:errors].size
    assert_equal "If you specify implementation, you must specify a practice name.", assigns[:errors][0][:message]
  end

  test "should autocomplete by practice name" do
    get :autocomplete_guideline_name, "term" => @guideline.name[0..4]

    assert_response :success
    r = JSON.parse(response.body)
    assert_equal 1, r.size
  end

  # test for autocomplete practice implementation names lives in practices_controller_test

  test "should search by badge" do
    get :index,
    "company" => {"name" => ""},
    "badge" => {"id" => @badge.id},
    "guideline" => {"id" => ""},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_response :success

    assert_equal 2, assigns[:companies].size
    assert_equal 0, assigns[:errors].size
  end

  test "should autocomplete by badge" do
    get :autocomplete_badge_name, "term" => "re"

    assert_response :success
    r = JSON.parse(response.body)
    puts r
    assert_equal 0, r.size
  end

  # Actions for Editors

  # Helper for testing access_denied
  def access_denied
    request.env["HTTP_REFERER"] = companies_path
    yield
    assert_redirected_to root_path
    assert_equal "You are not authorized to access this page.", flash[:alert]
  end

  test "should get new" do
    sign_in @editor
    get :new
    assert_response :success
  end

  test "should not get new" do
    access_denied do
      get :new
    end
  end

  test "should create" do
    sign_in @editor
    post :create, company: {name: 'acme', url: 'http://acme.com', description: 'sells everything'}
    assert_redirected_to company_path(assigns[:company].slug)
  end

  test "should not create" do
    access_denied do
      post :create, company: {name: 'acme', url: 'http://acme.com', description: 'sells everything'}
    end
  end

  test "should get edit" do
    sign_in @editor
    get :edit, id: @company.slug
    assert_response :success
  end

  test "should not get edit" do
    access_denied do
      get :edit, id: @company.slug
    end
  end

  test "should update" do
    sign_in @editor
    post :update, id: @company.slug, company: {name: 'acmezzzz'}
    assert_redirected_to company_path(assigns[:company].slug)
    assert_equal "acmezzzz", assigns(:company).name
    assert_equal @company.url, assigns(:company).url
  end

  test "should not update" do
    access_denied do
      post :update, id: @company.id, company: {name: 'acmezzzz'}
    end
  end

  # Admin only actions

  test "should not delete (anon user)" do
    count = Company.all.size

    access_denied do
      delete :destroy, id: @company.id
    end

    assert_equal count, Company.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = Company.all.size

    access_denied do
      delete :destroy, id: @company.id
    end

    assert_equal count, Company.all.size
  end

  test "should delete (admin user)" do
    sign_in @admin
    count = Company.all.size
    request.env["HTTP_REFERER"] = companies_path

    delete :destroy, id: @other_company

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to companies_path
    assert_equal count-1, Company.all.size
  end

  # Test for comparison view

  test "should not compare to self" do
    get :compare, :a => @company.slug, :b => @company.slug
    assert_redirected_to @company
    assert_equal "Cannot compare to self", flash[:alert]
  end

  test "should see comparison" do
  end

  # Controls for roles

  test "should be admin" do
    assert_equal true, @admin.admin?
    assert_equal false, @admin.editor?

  end

  test "should be editor" do
    assert_equal false, @editor.admin?
    assert_equal true, @editor.editor?
  end

end
