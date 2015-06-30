require 'test_helper'

class DispatchingsControllerTest < ActionController::TestCase
  setup do
    @dispatching = dispatchings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dispatchings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dispatching" do
    assert_difference('Dispatching.count') do
      post :create, dispatching: @dispatching.attributes
    end

    assert_redirected_to dispatching_path(assigns(:dispatching))
  end

  test "should show dispatching" do
    get :show, id: @dispatching.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dispatching.to_param
    assert_response :success
  end

  test "should update dispatching" do
    put :update, id: @dispatching.to_param, dispatching: @dispatching.attributes
    assert_redirected_to dispatching_path(assigns(:dispatching))
  end

  test "should destroy dispatching" do
    assert_difference('Dispatching.count', -1) do
      delete :destroy, id: @dispatching.to_param
    end

    assert_redirected_to dispatchings_path
  end
end
