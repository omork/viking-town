require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  test "When a roundhouse is created, it adds one villager to the village" do
    v = Villager.count
    user = user_with_nation_and_fjord
    user.fjords.first.villages.create! :name =>'asdf'
  
    assert_equal v + 1, Villager.count
    assert_equal "chief", user.fjords.first.villages.first.buildings.first.villagers.first.title
  end
  
  test "when a roundhouse brews, it makes beer, not brew" do
    user = user_with_nation_and_fjord
    user.fjords.first.villages << Factory(:village)
    building = user.buildings.first
    task = "brew"
    assert_nil user.fjords.first.villages.first.resources['beer']
    
    building.allocate(task)
    building.assigned_at = Time.now - 20
    building.completed_at = Time.now - 15
    building.check_task
    
    assert_equal 4, user.fjords.first.villages.first.resources['beer']
  end
end
