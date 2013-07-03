require 'test_helper'

class BuildingControllerTest < ActionController::TestCase
  test "assigning a task actually schedules that task for completion" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    
    sign_in user
    put :assign, :id => village.roundhouse.id, :building => {:task => 'brew'}
    
    assert_equal 'brew', village.roundhouse.reload.task
  end
  
  test "building a building works and has coordinates and the right type" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    
    sign_in user
    post :build, :id => village.id, :building => {:type => 'TurfHouse', :x => 1, :y => 1}
    
    building = village.buildings.last
    assert_equal 'TurfHouse', building.type
    assert_equal 1, building.x
    assert_equal 1, building.y
  end
end
