require 'test_helper'

class BuildingControllerTest < ActionController::TestCase
  test "assigning a task actually schedules that task for completion" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    
    sign_in user
    put :assign, :id => village.buildings.first.id, :building => {:task => 'brew'}
    
    assert_equal 'brew', village.buildings.first.task
  end
end
