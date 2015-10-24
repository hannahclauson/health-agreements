require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @company = create(:company)
    @unique_company = create(:company)

    # so that most of the search tests dont return a single result and redirect
    @very_similar_company = create(:company)
    @very_similar_company.name = @company.name + "xx"
    @very_similar_company.practices = @company.practices
    @very_similar_company.badges = @company.badges
    @very_similar_company.save!

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
    "archetype" => {"id" => ""},
    "guideline" => {"id" => ""},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_equal 1, assigns[:errors].size
    assert_equal "Empty search. Please provide a search term", assigns[:errors][0][:message]
  end

  test "should redirect w only one result" do
    get :index,
    "company" => {"name" => @company.name},
    "archetype" => {"id" => ""},
    "guideline" => {"id" => ""},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_redirected_to @company
  end

  test "should search by name" do
    get :index,
    "company" => {"name" => @company.name},
    "archetype" => {"id" => ""},
    "guideline" => {"id" => ""},
    "practice" => {"implementation" => ""},
    "commit" => "Search"

    assert_response :success

    assert_equal 2, assigns[:companies].size
    assert_equal 0, assigns[:errors].size
  end

  test "should autocomplete by name" do
  end

  test "should search by practice" do
  end

  test "should err when missing practice implementation" do
  end

  test "should err when missing practice name" do
  end

  test "should autocomplete by practice name" do
  end

  test "should autocomplete by practice value" do
  end

  test "should search by badge" do
  end

  test "should autocomplete by badge" do
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
