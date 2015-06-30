require 'test_helper'

class CustomerFlowsControllerTest < ActionController::TestCase
  setup do
    @customer_flow = customer_flows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_flows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_flow" do
    assert_difference('CustomerFlow.count') do
      post :create, customer_flow: @customer_flow.attributes
    end

    assert_redirected_to customer_flow_path(assigns(:customer_flow))
  end

  test "should show customer_flow" do
    get :show, id: @customer_flow.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_flow.to_param
    assert_response :success
  end

  test "should update customer_flow" do
    put :update, id: @customer_flow.to_param, customer_flow: @customer_flow.attributes
    assert_redirected_to customer_flow_path(assigns(:customer_flow))
  end

  test "should destroy customer_flow" do
    assert_difference('CustomerFlow.count', -1) do
      delete :destroy, id: @customer_flow.to_param
    end

    assert_redirected_to customer_flows_path
  end
end
