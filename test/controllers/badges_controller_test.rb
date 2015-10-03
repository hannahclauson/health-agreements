require 'test_helper'

class BadgesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @guideline = create(:guideline)
    @badge = create(:badge)
    @badge_practice = create(:badge_practice, guideline: @guideline, implementation: 1, badge: @badge)

    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Actions that are publicly accessible

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:badges)
  end

  test "should show" do
    get :show, :id => @badge.slug
    assert_response :success
    assert_not_nil assigns(:badge)
  end

  # Actions for Editors

  # Helper for testing access_denied
  def access_denied
    request.env["HTTP_REFERER"] = badges_path
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
    post :create, badge: {
      :name => 'free_service',
      :description => 'sells everything'
    }

    assert_equal 0, assigns[:badge].errors.size
    assert_redirected_to badge_path(assigns[:badge].id)
  end

  test "should not create" do
    access_denied do
    post :create, badge: {
      name: 'free_service',
      description: 'sells everything'
    }
    end
  end

  test "should get edit" do
    sign_in @editor
    get :edit, id: @badge.id
    assert_response :success
  end

  test "should not get edit" do
    access_denied do
      get :edit, id: @badge.id
    end
  end

  test "should update" do
    sign_in @editor
    g = create(
               :badge,
               name: "thing",
               description: "something something",
               true_description: "mhmm okay then",
               false_description: "mmmm nope not ok"
               )
    post :update, id: g.id, badge: {name: 'zzz'}
    assert_redirected_to badge_path(assigns[:badge].id)
    assert_equal "zzz", assigns(:badge).name
    assert_equal "something something", assigns(:badge).description
  end

  test "should not update" do
    access_denied do
      post :update, id: @badge.id, badge: {name: 'zzz'}
    end
  end

  # Admin only actions

  test "should not delete (anon user)" do
    count = Badge.all.size

    access_denied do
      delete :destroy, id: @badge.id
    end

    assert_equal count, Badge.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = Badge.all.size

    access_denied do
      delete :destroy, id: @badge.id
    end

    assert_equal count, Badge.all.size
  end

  test "should delete (admin user)" do
    sign_in @admin
    count = Badge.all.size
    request.env["HTTP_REFERER"] = badges_path

    delete :destroy, id: @badge.id

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to badges_path
    assert_equal count-1, Badge.all.size
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
