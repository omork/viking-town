require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  test "When a roundhouse is created, it adds one villager to the village" do
    v = Villager.count
    user = user_with_nation_and_fjord
    user.fjords.first.villages.create! :name =>'asdf'
  
    assert_equal v + 1, Villager.count
    assert_equal "chief", user.fjords.first.villages.first.buildings.first.villagers.first.title
  end
  
  test "can only assign valid tasks" do
    user = user_with_nation_and_fjord
    user.fjords.first.villages << Factory(:village)
    assert_raises Building::InvalidTask do
      user.buildings.first.allocate('an invalid task')
    end
  end
  
  test "when a task is assigned timestamps are updated" do
    user = user_with_nation_and_fjord
    user.fjords.first.villages << Factory(:village)
    building = user.buildings.first
    building.allocate(Building::TASKS[building.type].first)
    assert_in_delta Time.now.to_f, building.assigned_at.to_f, 5
  end
end
