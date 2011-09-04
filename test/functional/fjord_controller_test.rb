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
    user = Factory(:user, :nation => Factory(:nation))
    sign_in user
    
    post :settle, {:fjord => {}}
    assert_redirected_to :action => :list
    
    assert !user.fjords.empty?
  end

  test "should delete when calling abandon" do
    user = Factory(:user, :nation => Factory(:nation))
    user.fjords.create!(:name => 'asdf', :nation_id => user.nation_id)
    sign_in user
        
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
  
  test "can't update the nation once a fjord is created" do
    user = Factory(:user, :nation => Factory(:nation))
    sign_in user

    user.fjords.create!({:name => 'abce', :nation_id => user.nation_id})
    post :update, {:id => user.fjords.first.id, :fjord => {:nation_id => 6}}
    assert_response :success
    
    assert_equal user.nation_id, user.fjords(true).first.nation_id
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
