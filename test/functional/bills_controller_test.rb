require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = Factory(:user)
    sign_in @user
    @bill = Factory(:bill, :user => @user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill" do
    assert_difference('Bill.count') do
      post :create, :bill => { title: "Soup", amount: 5, date: 1.day.ago, user_ratio: 1, user_payed: 0, friend_payed: 5, friend_id: Factory(:friend).id }
    end

    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should show bill" do
    get :show, :id => @bill.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bill.to_param
    assert_response :success
  end

  test "should update bill" do
    put :update, :id => @bill.to_param, :bill => { title: "Soup", amount: 5, date: Time.now, user_ratio: 1, user_payed: 0, friend_payed: 5 }
    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should destroy bill" do
    assert_difference('Bill.count', -1) do
      delete :destroy, :id => @bill.to_param
    end

    assert_redirected_to bills_path
  end
end

