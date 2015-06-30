require 'test_helper'

class RepairsControllerTest < ActionController::TestCase
  setup do
    @repair = repairs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repairs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repair" do
    assert_difference('Repair.count') do
      post :create, repair: @repair.attributes
    end

    assert_redirected_to repair_path(assigns(:repair))
  end

  test "should show repair" do
    get :show, id: @repair.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repair.to_param
    assert_response :success
  end

  test "should update repair" do
    put :update, id: @repair.to_param, repair: @repair.attributes
    assert_redirected_to repair_path(assigns(:repair))
  end

  test "should destroy repair" do
    assert_difference('Repair.count', -1) do
      delete :destroy, id: @repair.to_param
    end

    assert_redirected_to repairs_path
  end
end
