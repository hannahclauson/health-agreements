require 'test_helper'

class ContributionsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Actions for Editors

  def access_denied
    request.env["HTTP_REFERER"] = new_contribution_path
    yield
    assert_redirected_to root_path
    assert_equal "You are not authorized to access this page.", flash[:alert]
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create" do
    post :create, contribution: {kind: "article", url: "http://thing.com"}

    assert_equal 0, assigns[:contribution].errors.size
    assert_redirected_to new_contribution_path
  end

  test "should not view submissions" do
    access_denied do
      get :submissions
    end
  end

end
