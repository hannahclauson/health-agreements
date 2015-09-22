require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @company = create(:company)
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
    get :show, :id => @company.id
    assert_response :success
    assert_not_nil assigns(:company)
  end

  # Actions for Editors

  # Helper for simulating anon request
  def anon_access
    request.env["HTTP_REFERER"] = companies_path
    yield
    assert_redirected_to companies_path
  end

  test "should get new" do
    sign_in @editor
    get :new
    assert_response :success
  end

  test "should not get new" do
    anon_access do
      get :new
    end
  end

  test "should create" do
    sign_in @editor
    post :create, company: {name: 'acme', url: 'http://acme.com', description: 'sells everything'}
    assert_redirected_to company_path(assigns[:company].id)
  end

  test "should not create" do
    anon_access do
      post :create, company: {name: 'acme', url: 'http://acme.com', description: 'sells everything'}
    end
  end

  test "should get edit" do
    sign_in @editor
    get :edit, id: @company.id
    assert_response :success
  end

  test "should not get edit" do
    anon_access do
      get :edit, id: @company.id
    end
  end

  test "should update" do
    sign_in @editor
    post :update, id: @company.id, company: {name: 'acmezzzz'}
    assert_redirected_to company_path(assigns[:company].id)
    assert_equal "acmezzzz", assigns(:company).name
    assert_equal @company.url, assigns(:company).url
  end

  test "should not update" do
    anon_access do
      post :update, id: @company.id, company: {name: 'acmezzzz'}
    end
  end


end
