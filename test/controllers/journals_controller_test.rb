require 'test_helper'

class JournalsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @journal = create(:journal)
    @other_journal = create(:journal, impact_factor: 7)

    @company = create(:company)
    a = create(:article, company: @company, journal: @other_journal)

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
    get :index
    assert_response :success
    assert_equal 2, assigns(:journals).size
  end

  test "should get show" do
    get :show, :id => @journal
    assert_response :success
    assert_not_nil assigns(:journal)
  end

  # Test editor access actions w neg controls



  test "should not get edit" do
    access_denied do
      get :edit, id: @journal
    end
  end

  test "should get edit" do
    sign_in @editor
    get :edit, id: @journal
    assert_response :success
    assert_not_nil assigns(:journal)
  end

  test "should not update" do
    access_denied do
      post :update, id: @journal, journal: {name: 'acmezzzz'}
    end
  end

  test "should update" do
    sign_in @editor
    post :update, id: @journal, journal: {name: 'acmezzzz'}
    assert_redirected_to journal_path(assigns[:journal])
    assert_equal "acmezzzz", assigns(:journal).name
    assert_equal @journal.url, assigns(:journal).url
  end

  test "should company impact factor updated on journal  update" do
    sign_in @editor
    assert_equal 10, @company.impact_factor
    post :update, id: @journal, journal: {impact_factor: 25}
    assert_redirected_to journal_path(assigns[:journal])
    assert_equal 25, @company.impact_factor
  end

  test "should not get new" do
    access_denied do
      get :new
    end
  end

  test "should get new" do
    sign_in @editor
    get :new
    assert_response :success
  end

  test "should not create" do
    access_denied do
      post :create, journal: {name: 'acme', url: 'http://acme.com', impact_factor: 23.4}
    end
  end

  test "should create" do
    sign_in @editor
    post :create, journal: {name: 'acme', url: 'http://acme.com', impact_factor: 23.4}
    assert_redirected_to journal_path(assigns[:journal])
  end

  test "should not delete (anon user)" do
    count = Journal.all.size

    access_denied do
      delete :destroy, id: @journal.id
    end

    assert_equal count, Journal.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = Journal.all.size

    access_denied do
      delete :destroy, id: @journal.id
    end

    assert_equal count, Journal.all.size
  end

  test "should delete" do
    sign_in @admin
    count = Journal.all.size
    request.env["HTTP_REFERER"] = journals_path

    delete :destroy, id: @other_journal

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to journals_path
    assert_equal count-1, Journal.all.size
  end

  test "should company impact factor updated on journal delete" do
    sign_in @admin
    count = Journal.all.size
    request.env["HTTP_REFERER"] = journals_path

    assert_equal 7, @company.impact_factor

    delete :destroy, id: @other_journal

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to journals_path
    assert_equal count-1, Journal.all.size

    assert_equal nil, @company.impact_factor
  end

end
