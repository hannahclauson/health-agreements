require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @company = companies('23andme')
    @editor = users(:emily_editor)
    @editor.confirm
    @admin = users(:amon_admin)
    @admin.confirm
  end

  # Public Access Tests

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should not create" do
    request.env["HTTP_REFERER"] = companies_path
    post :create, company: {name: 'acme', url: 'http://acme.com', description: 'sells everything'}
    assert_redirected_to companies_path
  end

  test "should show" do
    get :show, :id => @company.id
    assert_response :success
    assert_not_nil assigns(:company)
  end

  # Editor Tests

  test "should get new" do
    sign_in @editor
    get :new
    assert_response :success
  end

  test "should create" do
    sign_in @editor
    post :create, company: {name: 'acme', url: 'http://acme.com', description: 'sells everything'}
    assert_not_nil @response.headers['Location']
    assert_redirected_to company_path(assigns[:company].id)
  end

  test "should get edit" do
    sign_in @editor
    get :edit, id: @company.id
    assert_response :success
  end





end
