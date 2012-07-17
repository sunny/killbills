require 'test_helper'

class DevisePasswordsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup {
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @controller = Devise::PasswordsController.new
  }

  # "Forgot your password?" page
  should "get /users/password/new" do
    get :new
    assert_response :success
  end

  # Submit from "Forgot your password?" page
  should "post /users/password" do
    user = FactoryGirl.create(:user)
    post :create, { user: { email: user.email } }
    assert_redirected_to users_sign_in_path
  end

end

