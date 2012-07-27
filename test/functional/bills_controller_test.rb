require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = create :user
    @bill = create :bill, user: @user
    create :participation, bill: @bill, person: @user
    create :participation, bill: @bill, person: create(:friend)
    sign_in @user
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
      post :create, :bill => { title: "Soup", date: 1.day.ago }
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
    put :update, :id => @bill.to_param, :bill => { title: "Soup", date: Time.now }
    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should destroy bill" do
    assert_difference('Bill.count', -1) do
      delete :destroy, :id => @bill.to_param
    end

    assert_redirected_to bills_path
  end
end

