require 'test_helper'

class FjordControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get settle" do
    get :settle
    assert_response :success
  end

  test "should get abandon" do
    get :abandon
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
