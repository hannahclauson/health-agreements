require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @company = companies('23andme')
    @editor = users(:emily_editor)
    @editor.confirm!
    @admin = users(:amon_admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get edit" do
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @editor
    get :edit, id: @company.id
    puts "request"
    puts @request.inspect
    puts "response"
    puts @response.inspect

    assert_response :success
  end

end
