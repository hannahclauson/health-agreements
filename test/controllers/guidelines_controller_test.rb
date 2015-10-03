require 'test_helper'

class GuidelinesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @guideline = create(:guideline)
    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Actions that are publicly accessible

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guidelines)
  end

  test "should show" do
    get :show, :id => @guideline.id
    assert_response :success
    assert_not_nil assigns(:guideline)
  end

  # Actions for Editors

  # Helper for testing access_denied
  def access_denied
    request.env["HTTP_REFERER"] = guidelines_path
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
    post :create, guideline: {
      :name => 'free_service',
      :description => 'sells everything',
      :true_description => 'does it asdklfjhasldkgjhsdfg',
      :false_description => 'doesnt do it asdfkljhsdflgkjhg'
    }

    assert_equal 0, assigns[:guideline].errors.size
    assert_redirected_to guideline_path(assigns[:guideline].id)
  end

  test "should not create" do
    access_denied do
    post :create, guideline: {
      name: 'free_service',
      description: 'sells everything',
      true_description: 'does it askjhfslkdfjghsdfg',
      false_description: 'doesnt do it asdfjhsdflkgjh'
    }
    end
  end

  test "should get edit" do
    sign_in @editor
    get :edit, id: @guideline.id
    assert_response :success
  end

  test "should not get edit" do
    access_denied do
      get :edit, id: @guideline.id
    end
  end

  test "should update" do
    sign_in @editor
    g = create(
               :guideline,
               name: "thing",
               description: "something something",
               true_description: "mhmm okay then",
               false_description: "mmmm nope not ok"
               )
    post :update, id: g.id, guideline: {name: 'zzz'}
    assert_redirected_to guideline_path(assigns[:guideline].id)
    assert_equal "zzz", assigns(:guideline).name
    assert_equal "something something", assigns(:guideline).description
  end

  test "should not update" do
    access_denied do
      post :update, id: @guideline.id, guideline: {name: 'zzz'}
    end
  end

  # Admin only actions

  test "should not delete (anon user)" do
    count = Guideline.all.size

    access_denied do
      delete :destroy, id: @guideline.id
    end

    assert_equal count, Guideline.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = Guideline.all.size

    access_denied do
      delete :destroy, id: @guideline.id
    end

    assert_equal count, Guideline.all.size
  end

  test "should delete (admin user)" do
    sign_in @admin
    count = Guideline.all.size
    request.env["HTTP_REFERER"] = guidelines_path

    delete :destroy, id: @guideline.id

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to guidelines_path
    assert_equal count-1, Guideline.all.size
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
