require 'test_helper'

class ShipControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get scuttle" do
    get :scuttle
    assert_response :success
  end

  test "should get build" do
    get :build
    assert_response :success
  end

end
