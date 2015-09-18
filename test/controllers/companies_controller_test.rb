require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  include Devise::TestHelpers

  def asign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  def orsetup
#    @request.env["devise.mapping"] = Devise.mappings[:admin]
#    sign_in FactoryGirl.create(:admin)
  end

  test "should get index" do
    #    @request.env["devise.mapping"] = Devise.mappings[:user]
#    @request.env["devise.mapping"] = Devise.mappings[:admin]
#    sign_in nil
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end



end
