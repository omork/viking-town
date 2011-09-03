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
    
    post :settle, {:name => "my fjord has a name!"}
    assert_response :success
    
    delete :abandon, :id => user.fjords.first.id
    assert_response :success
  end

  test "should update" do
    user = Factory(:user, :nation => Factory(:nation))
    sign_in user

    user.fjords.create!({:name => 'abce', :nation_id => user.nation_id})
    post :update, {:id => user.fjords.first.id, :fjord => {:name => 'asdf'}}
    assert_response :success
        
    assert_equal 'asdf', user.fjords(true).first.name
  end

  test "should get show" do
    user = Factory(:user, :nation => Factory(:nation))
    sign_in user

    user.fjords.create!({:name => 'abce', :nation_id => user.nation_id})

    get :show, {:id => user.fjords.first.id}
    assert_response :success
    assert assigns(:fjord)
  end
  
  test "abandon deletes the fjord" do
    user = Factory(:user, :nation => Factory(:nation))
    sign_in user

    user.fjords.create!({:name => 'abce', :nation_id => user.nation_id})
    
    delete :abandon, {:id => user.fjords.first.id}
    assert_response :success
    
    assert user.fjords(true).empty?
  end
end
