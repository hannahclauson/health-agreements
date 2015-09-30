require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @company = create(:company)
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

  # Actions for Editors

  # Helper for testing access_denied
  def access_denied
    request.env["HTTP_REFERER"] = companies_path
    yield
    assert_redirected_to companies_path
    assert_equal "Access Denied", flash[:alert]
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
    anon_access do
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
      delete :destroy, id: companies(:fodder_a).id
    end

    assert_equal count, Company.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = Company.all.size

    access_denied do
      delete :destroy, id: companies(:fodder_a).id
    end

    assert_equal count, Company.all.size
  end

  test "should delete (admin user)" do
    sign_in @admin
    count = Company.all.size
    request.env["HTTP_REFERER"] = companies_path

    delete :destroy, id: companies(:fodder_a).id

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
