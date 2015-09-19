require 'test_helper'

class PracticesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  include ActionDispatch::Routing::PolymorphicRoutes
  include Rails.application.routes.url_helpers

  setup do
    @practice = practices(:one)

    @guideline = guidelines(:single_state)
    @guideline.save!

    @editor = users(:emily_editor)
    @editor.confirm
    @admin = users(:amon_admin)
    @admin.admin!
    @admin.confirm
  end

  # Actions that are publicly accessible

  test "should not get index" do
    get :index
    assert_response :failure
  end

  # Actions for Editors

  # Helper for testing access_denied

  def parent_path(p)
    polymorphic_path(p.practiceable)
  end

  def access_denied(p)
    request.env["HTTP_REFERER"] = parent_path(p)
    yield
    assert_redirected_to parent_path(p)
    assert_equal "Access Denied", flash[:alert]
  end

  def parent_class(p)
    p.practiceable.class
  end

  test "should get show" do
    puts "practiceable id #{@practice.practiceable.id}"
    get :show, company_id: @practice.practiceable, id: @practice
    assert_response :success
  end

  test "should create via company" do
    sign_in @editor

    post :create, company_id: @practice.practiceable, practice: {
      :notes => 'for realsies',
      :implementation => 1,
      :guideline_id => @guideline.id,
      :company => @practice.practiceable
    }

    assert_equal 0, assigns[:practice].errors.size
    assert_redirected_to parent_path(@practice)
  end

  test "should not create via company with redundant practice name" do
    sign_in @editor

    post :create, company_id: @practice.practiceable, practice: {
      :notes => 'for realsies',
      :implementation => 1,
      :guideline_id => guidelines(:optin),
      :company => @practice.practiceable
    }

    assert_equal 1, assigns[:practice].errors.size
    assert_redirected_to parent_path(@practice)
  end

  test "should not create via company" do
    access_denied(@practice) do
      post :create, company_id: @practice.practiceable, practice: {
        :notes => 'for realsies',
        :implementation => 1,
        :guideline_id => @guideline.id,
        :company => @practice.practiceable
      }
    end
  end

  test "should not create" do
    access_denied(@practice) do
    post :create, practice: {
      :notes => 'for realsies',
      :implementation => 1,
      :guideline => guidelines(:single_state),
      :practiceable => companies('23andme')
    }
    end
  end

  test "should get edit" do
    sign_in @editor
    get :edit, id: @practice.id
    assert_response :success
  end

  test "should not get edit" do
    access_denied(@practice) do
      get :edit, id: @practice.id
    end
  end

  test "should update" do
    sign_in @editor
    post :update, id: @practice.id, practice: {name: 'zzz'}
    assert_redirected_to practice_path(assigns[:practice].id)
    assert_equal "zzz", assigns(:practice).name
    assert_equal "Opt in for data use in research", assigns(:practice).description
  end

  test "should not update" do
    access_denied(@practice) do
      post :update, id: @practice.id, practice: {name: 'zzz'}
    end
  end

  # Admin only actions

  test "should not delete (anon user)" do
    count = Practice.all.size

    access_denied(@practice) do
      delete :destroy, id: @practice.id
    end

    assert_equal count, Practice.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = Practice.all.size

    access_denied(@practice) do
      delete :destroy, id: @practice.id
    end

    assert_equal count, Practice.all.size
  end

  test "should delete (admin user)" do
    sign_in @admin
    count = Practice.all.size
    request.env["HTTP_REFERER"] = parent_path

    delete :destroy, id: @practice.id

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to parent_path
    assert_equal count-1, Practice.all.size
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
