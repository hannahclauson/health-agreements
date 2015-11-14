require 'test_helper'

class GuidelineTagsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @guideline_tag = create(:guideline_tag)

    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Actions that are publicly accessible

  test "should get not index" do
    access_denied do
      get :index
    end
  end

  test "should get index" do
    sign_in @editor
    get :index
    assert_response :success
    assert_not_nil assigns(:guideline_tags)
  end

  # Actions for Editors

  # Helper for testing access_denied
  def access_denied
    request.env["HTTP_REFERER"] = guideline_tags_path
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
    post :create, guideline_tag: {
      :name => 'free_service'
    }

    assert_equal 0, assigns[:guideline_tag].errors.size
    assert_redirected_to guideline_tags_path
  end

  test "should not create" do
    access_denied do
    post :create, guideline_tag: {
      name: 'free_service'
    }
    end
  end

  # Admin only actions

  test "should not delete (anon user)" do
    count = GuidelineTag.all.size

    access_denied do
      delete :destroy, id: @guideline_tag.id
    end

    assert_equal count, GuidelineTag.all.size
  end

  test "should delete (editor user)" do
    sign_in @editor
    count = GuidelineTag.all.size

    delete :destroy, id: @guideline_tag.id

    assert_redirected_to guideline_tags_path
    assert_equal count-1, GuidelineTag.all.size
  end

  test "should delete (admin user)" do
    sign_in @admin
    count = GuidelineTag.all.size
    request.env["HTTP_REFERER"] = guideline_tags_path

    delete :destroy, id: @guideline_tag.id

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to guideline_tags_path
    assert_equal count-1, GuidelineTag.all.size
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

