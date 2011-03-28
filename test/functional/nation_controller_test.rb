require 'test_helper'

class NationControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get align" do
    get :align
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

end
