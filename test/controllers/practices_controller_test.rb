require 'test_helper'

class PracticesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @company = create(:company)
    tag_a = create(:guideline_tag, name: "Good")
    tab_b = create(:guideline_tag, name: "Bad")

    @guideline = create(:guideline, name: 'single_state', guideline_tag: tag_a)
    guideline_b = create(:guideline, name: 'yupyupyup')
    @practice = create(:practice, guideline: @guideline, company: @company)

    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Actions for Editors

  def access_denied(p)
    request.env["HTTP_REFERER"] = company_path(p)
    yield
    assert_redirected_to root_path
    assert_equal "You are not authorized to access this page.", flash[:alert]
  end

  test "should get show" do
    get :show, company_id: @practice.company, id: @practice
    assert_response :success
  end

  test "should create via company" do
    sign_in @editor

    g = create(:guideline)
    post :create, company_id: @practice.company, practice: {
      :notes => 'for realsies',
      :implementation => 1,
      :guideline_id => g.id,
      :company => @practice.company
    }

    assert_equal 0, assigns[:practice].errors.size
    assert_redirected_to company_path(@company)
  end

  test "should not create via company with redundant guideline" do
    sign_in @editor

    count = @practice.company.practices.size

    post :create, company_id: @practice.company, practice: {
      :notes => 'for realsies',
      :implementation => 1,
      :guideline_id => @guideline,
      :company => @practice.company
    }

    assert_equal count, @practice.company.practices.size
    assert_equal 1, assigns[:practice].errors.size
    assert_response :success
  end

  test "should not create via company" do
    access_denied(@practice) do
      post :create, company_id: @practice.company, practice: {
        :notes => 'for realsies',
        :implementation => 1,
        :guideline_id => @guideline.id,
        :company => @practice.company
      }
    end
  end

  test "should not create" do
    access_denied(@practice) do
    post :create, company_id: @company, practice: {
      :notes => 'for realsies',
      :implementation => 1,
      :guideline => @guideline,
      :company => @company
    }
    end
  end

  test "should get edit" do
    sign_in @editor
    get :edit, company_id: @company, id: @practice
    assert_response :success
  end

  test "should not get edit" do
    access_denied(@practice) do
      get :edit, company_id: @company, id: @practice
    end
  end

  test "should update" do
    sign_in @editor
    g = create(:guideline)
    p = create(:practice, implementation: 1, notes: 'zzz', guideline: g, company: @company)
    post :update, company_id: @company, id: p, practice: {implementation: 2}
    assert_redirected_to company_path( assigns[:practice].company )
    assert_equal 2, assigns(:practice).implementation
    assert_equal 'zzz', assigns(:practice).notes
  end

  test "should not update" do
    access_denied(@practice) do
      post :update, company_id: @company, id: @practice, practice: {name: 'zzz'}
    end
  end

  # Tests for batch creation

  test "should not access batch new" do
    access_denied(@practice) do
      get :batch_new, company_id: @company
    end
  end

  test "should access batch new" do
    sign_in @editor
    get :batch_new, company_id: @company
    assert_equal nil, flash[:alert]
    assert_response :success
  end

  test "should create several new practices" do
    sign_in @editor

    g2 = create(:guideline, name: 'foo')
    g3 = create(:guideline, name: 'bar')

    count = Practice.all.size

    post :batch_create, company_id: @company,
      :enabled => {
        g2.id.to_s => "enabled",
        g3.id.to_s => "enabled"
      },
      :practices => [
      {
        :implementation => 1,
        :guideline_id => g2.id
      },
      {
        :implementation => 2,
        :guideline_id => g3.id
      }
      ]

    assert_equal count+2, Practice.all.size
    assert_redirected_to company_path(@company)

  end

  test "should not create practice unless checkbox is clicked" do
  end

  test "should report error inline for practice" do
    sign_in @editor

    count = Practice.all.size
    g2 = create(:guideline, name: 'foo')


    post :batch_create, company_id: @company,
      :enabled => {
        g2.id.to_s => "enabled"
      },
      :practices => [
      {
        :implementation => nil,
        :guideline_id => g2.id
      }
      ]

    assert_equal count, Practice.all.size
    assert_equal 2, assigns[:practices][g2.id].errors.size
    assert_response :success
  end

  test "should report errors for several practices w errors" do
    sign_in @editor

    count = Practice.all.size
    g2 = create(:guideline, name: 'foo')
    g3 = create(:guideline, name: 'bar')


    post :batch_create, company_id: @company,
      :enabled => {
        g2.id.to_s => "enabled",
        g3.id.to_s => "enabled"
      },
      :practices => [
      {
        :implementation => nil,
        :guideline_id => g2.id
      },
      {
        :implementation => nil,
        :guideline_id => g3.id
      }
      ]

    assert_equal count, Practice.all.size
    assert_equal 2, assigns[:practices][g2.id].errors.size
    assert_equal 2, assigns[:practices][g3.id].errors.size
    assert_response :success
  end

  test "should create several new practices and report several other errors" do
    sign_in @editor

    count = Practice.all.size
    g2 = create(:guideline, name: 'foo')
    g3 = create(:guideline, name: 'bar')
    g4 = create(:guideline, name: 'baz')
    g5 = create(:guideline, name: 'zzz')

    post :batch_create, company_id: @company,
      :enabled => {
        g2.id.to_s => "enabled",
        g3.id.to_s => "enabled",
        g4.id.to_s => "enabled",
        g5.id.to_s => "enabled"
      },
      :practices => [
      {
        :implementation => nil,
        :guideline_id => g2.id
      },
      {
        :implementation => nil,
        :guideline_id => g3.id
      },
      {
        :implementation => 1,
        :guideline_id => g4.id
      },
      {
        :implementation => 2,
        :guideline_id => g5.id
      }
      ]

    assert_equal count+2, Practice.all.size
    assert_equal 2, assigns[:practices][g2.id].errors.size
    assert_equal 2, assigns[:practices][g3.id].errors.size
    assert_response :success
  end

  # Admin only actions

  test "should not delete (anon user)" do
    count = Practice.all.size

    access_denied(@practice) do
      delete :destroy, company_id: @company, id: @practice
    end

    assert_equal count, Practice.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = Practice.all.size

    access_denied(@practice) do
      delete :destroy, company_id: @company, id: @practice
    end

    assert_equal count, Practice.all.size
  end

  test "should delete (admin user)" do
    sign_in @admin
    count = Practice.all.size
    request.env["HTTP_REFERER"] = company_path(@company)

    delete :destroy, company_id: @company, id: @practice

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to company_path(@company)
    assert_equal count-1, Practice.all.size
  end

  test "should autocomplete by practice value" do
    get 'autocomplete_implementations', "term" => "fo"
    # For now expect all results no matter what search term since there are so few

    assert_response :success
    r = JSON.parse(response.body)
    assert_equal 5, r.size
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
