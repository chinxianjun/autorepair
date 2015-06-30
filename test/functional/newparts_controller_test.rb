require 'test_helper'

class NewpartsControllerTest < ActionController::TestCase
  setup do
    @newpart = newparts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newparts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newpart" do
    assert_difference('Newpart.count') do
      post :create, newpart: @newpart.attributes
    end

    assert_redirected_to newpart_path(assigns(:newpart))
  end

  test "should show newpart" do
    get :show, id: @newpart.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newpart.to_param
    assert_response :success
  end

  test "should update newpart" do
    put :update, id: @newpart.to_param, newpart: @newpart.attributes
    assert_redirected_to newpart_path(assigns(:newpart))
  end

  test "should destroy newpart" do
    assert_difference('Newpart.count', -1) do
      delete :destroy, id: @newpart.to_param
    end

    assert_redirected_to newparts_path
  end
end
