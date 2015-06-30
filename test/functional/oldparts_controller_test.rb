require 'test_helper'

class OldpartsControllerTest < ActionController::TestCase
  setup do
    @oldpart = oldparts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oldparts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oldpart" do
    assert_difference('Oldpart.count') do
      post :create, oldpart: @oldpart.attributes
    end

    assert_redirected_to oldpart_path(assigns(:oldpart))
  end

  test "should show oldpart" do
    get :show, id: @oldpart.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @oldpart.to_param
    assert_response :success
  end

  test "should update oldpart" do
    put :update, id: @oldpart.to_param, oldpart: @oldpart.attributes
    assert_redirected_to oldpart_path(assigns(:oldpart))
  end

  test "should destroy oldpart" do
    assert_difference('Oldpart.count', -1) do
      delete :destroy, id: @oldpart.to_param
    end

    assert_redirected_to oldparts_path
  end
end
