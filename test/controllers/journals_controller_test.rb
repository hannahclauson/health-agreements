require 'test_helper'

class JournalsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @journal = create(:journal)
  end

  test "should get index" do
    get "index"
    assert_response :success
    assert_equal 4, assigns(@journals).size
  end


end
