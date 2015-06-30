require 'test_helper'

class NewflowsControllerTest < ActionController::TestCase
  setup do
    @newflow = newflows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newflows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newflow" do
    assert_difference('Newflow.count') do
      post :create, newflow: @newflow.attributes
    end

    assert_redirected_to newflow_path(assigns(:newflow))
  end

  test "should show newflow" do
    get :show, id: @newflow.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newflow.to_param
    assert_response :success
  end

  test "should update newflow" do
    put :update, id: @newflow.to_param, newflow: @newflow.attributes
    assert_redirected_to newflow_path(assigns(:newflow))
  end

  test "should destroy newflow" do
    assert_difference('Newflow.count', -1) do
      delete :destroy, id: @newflow.to_param
    end

    assert_redirected_to newflows_path
  end
end
