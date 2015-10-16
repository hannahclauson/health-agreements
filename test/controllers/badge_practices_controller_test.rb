require 'test_helper'

class BadgePracticesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @badge = create(:badge)
    @guideline = create(:guideline, name: 'single_state')
    @badge_practice = create(:badge_practice, guideline: @guideline, badge: @badge)

    @editor = create(:user)
    @admin = create(:user, :admin)
  end

  # Actions for Editors

  def access_denied(p)
    request.env["HTTP_REFERER"] = "FOO" #badge_path(p)
    yield
    assert_redirected_to root_path
    assert_equal "You are not authorized to access this page.", flash[:alert]
  end

  test "should create via badge" do
    puts "TEST:: should create via badge"
    sign_in @editor

    g = create(:guideline)
    post :create, badge_id: @badge_practice.badge, badge_practice: {
      :implementation => 1,
      :guideline_id => g.id,
      :badge => @badge_practice.badge
    }

    assert_equal 0, assigns[:badge_practice].errors.size
    assert_redirected_to badge_path(@badge)
  end

  test "should not create via badge with redundant guideline" do
    puts "TEST:: should not create via badge with redundant guideline"
    sign_in @editor

    count = @badge_practice.badge.badge_practices.size

    post :create, badge_id: @badge_practice.badge.slug, badge_practice: {
      :implementation => 1,
      :guideline_id => @guideline,
      :badge => @badge_practice.badge
    }

    assert_equal count, @badge_practice.badge.badge_practices.size
    assert_equal 1, assigns[:badge_practice].errors.size
    assert_response :success
  end

  test "should not create via badge" do
    puts "TEST:: SHOULD NOT CREATE VIA BADGE"
    access_denied(@badge_practice) do
      puts "creating guideline"
      g2 = create(:guideline)
      puts "submitting create post"
      post :create, badge_id: @badge_practice.badge, badge_practice: {
        :implementation => 1,
        :guideline => g2,
        :badge => @badge_practice.badge
      }
      puts "done submitting create post"
    end
  end


  # Admin only actions

  test "should not delete (anon user)" do
    count = BadgePractice.all.size

    access_denied(@badge_practice) do
      delete :destroy, badge_id: @badge.slug, id: @badge_practice.id
    end

    assert_equal count, BadgePractice.all.size
  end

  test "should not delete (editor user)" do
    sign_in @editor
    count = BadgePractice.all.size

    access_denied(@badge_practice) do
      delete :destroy, badge_id: @badge.slug, id: @badge_practice
    end

    assert_equal count, BadgePractice.all.size
  end

  test "should delete (admin user)" do
    sign_in @admin
    count = BadgePractice.all.size
    request.env["HTTP_REFERER"] = badge_path(@badge)

    delete :destroy, badge_id: @badge.slug, id: @badge_practice

    assert_equal true, @admin.admin?
    assert_equal nil, flash[:alert]

    assert_redirected_to badge_path(@badge)
    assert_equal count-1, BadgePractice.all.size
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
