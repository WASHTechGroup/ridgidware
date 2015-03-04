require 'test_helper'

class HoldsControllerTest < ActionController::TestCase
  setup do
    @hold = holds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:holds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hold" do
    assert_difference('Hold.count') do
      post :create, hold: {  }
    end

    assert_redirected_to hold_path(assigns(:hold))
  end

  test "should show hold" do
    get :show, id: @hold
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hold
    assert_response :success
  end

  test "should update hold" do
    patch :update, id: @hold, hold: {  }
    assert_redirected_to hold_path(assigns(:hold))
  end

  test "should destroy hold" do
    assert_difference('Hold.count', -1) do
      delete :destroy, id: @hold
    end

    assert_redirected_to holds_path
  end
end
