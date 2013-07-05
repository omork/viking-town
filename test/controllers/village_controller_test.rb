require 'test_helper'

class VillageControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should found a village" do
    user = Factory(:user, :nation => Factory(:nation))
    Factory(:fjord, :user_id => user.id, :nation_id => user.nation.id)
    sign_in user
    
    post :found, {:village => {:fjord_id => user.fjords.first.id, :name => 'adsf'}}
    assert_redirected_to :action => :show, :id => user.fjords.first.villages.first.id
    
    assert !user.fjords.first.villages.empty?
  end
  
  test "abandoning a village should destroy it" do
    user = Factory(:user, :nation => Factory(:nation))
    fjord = Factory(:fjord, :user_id => user.id, :nation_id => user.nation.id)
    fjord.villages.create!(:name => 'asdf')
    sign_in user

    delete :abandon, :id => fjord.villages.first.id
    assert_response :success
    
    assert fjord.villages(true).empty?
  end
  
  test "should get update" do
    user = Factory(:user, :nation => Factory(:nation))
    fjord = Factory(:fjord, :user_id => user.id, :nation_id => user.nation.id)
    fjord.villages.create!(:name => 'asdf')
    sign_in user

    post :update, {:id => fjord.villages.first.id, :village => {:name => 'fdsa'}}
    assert_response :success
    
    assert_equal 'fdsa', fjord.villages(true).first[:name]
  end
  
  test "should get show" do
    user = Factory(:user, :nation => Factory(:nation))
    fjord = Factory(:fjord, :user_id => user.id, :nation_id => user.nation.id)
    fjord.villages.create!(:name => 'asdf')
    sign_in user

    get :show, {:id => fjord.villages.first.id}
    assert_response :success
    assert assigns(:village)
    assert_equal fjord.villages.first.id, assigns(:village).id
  end
end
