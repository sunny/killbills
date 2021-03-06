require 'test_helper'

class OptionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = create :user
    sign_in @user
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get update" do
    assert_equal 'USD', @user.currency
    get :update, user: { currency: 'EUR' }
    assert_redirected_to edit_options_path
    assert_equal 'EUR', User.find(@user).currency
  end

end
