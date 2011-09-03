require 'test_helper'

class FjordControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should get list" do
    get :list
    assert_response :success
    assert assigns :fjords
  end

  test "should get list with specific page" do
    get :list, { :page =>1 }
    assert_response :success
    assert assigns :fjords
  end
  
  test "should start a settlement" do
    sign_in Factory(:user, :nation => Factory(:nation))
    
    post :settle, Hash.new
    assert_response :success
  end

  test "should delete when calling abandon" do
    user = Factory(:user, :nation => Factory(:nation))
    sign_in user
    
    post :settle, Hash.new
    assert_response :success
    
    delete :abandon, :id => user.fjords.first.id
    assert_response :success
  end

  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end
  # 
  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end
end
