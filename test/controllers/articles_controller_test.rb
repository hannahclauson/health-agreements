require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @article = create(:article)
    other_article = create(:article)

    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Helper for testing access_denied
  def access_denied
    request.env["HTTP_REFERER"] = articles_path
    yield
    assert_redirected_to root_path
    assert_equal "You are not authorized to access this page.", flash[:alert]
  end

  test "should get show" do
    get "show", :id => @article
    assert_response :success
    assert_not_nil assigns(:article)
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
