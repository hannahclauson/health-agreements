require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "have badges loaded" do
    get :index
    assert_response :success
    assert_not_nil assigns[:badges]

    # Want to be specific about what we're using so it doesnt break
    assert_not_nil assigns[:badges]["Research"]
    assert_not_nil assigns[:badges]["HIPAA Compliance"]
    assert_not_nil assigns[:badges]["Single State Hosted"]
  end
end
