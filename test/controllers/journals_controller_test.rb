require 'test_helper'

class JournalsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @journal = create(:journal)
    other_journal = create(:journal)

    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Helper for testing access_denied
  def access_denied
    request.env["HTTP_REFERER"] = journals_path
    yield
    assert_redirected_to root_path
    assert_equal "You are not authorized to access this page.", flash[:alert]
  end

  test "should get index" do
    get "index"
    assert_response :success
    assert_equal 2, assigns(:journals).size
  end

  test "should get show" do
    get "show", :id => @journal.slug
    assert_response :success
    assert_not_nil assigns(:journal)
  end

  # Test editor access actions w neg controls



  test "should not get edit" do
  end

  test "should get edit" do
  end

  test "should not update" do
  end

  test "should update" do
  end

  test "should not get new" do
  end

  test "should get new" do
  end

  test "should not create" do
  end

  test "should create" do
  end

  test "should not delete (anon user)" do
  end

  test "should not delete (editor user)" do
  end

  test "should delete" do
  end

end
