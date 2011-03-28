require 'test_helper'

class VillagerControllerTest < ActionController::TestCase
  test "should get allocate" do
    get :allocate
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
