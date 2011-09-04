require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  test "When a roundhouse is created, it adds one villager to the village" do
    v = Villager.count
    
    user = user_with_nation_and_fjord
    user.fjords.first.villages.create! :name =>'asdf'
  
    assert_equal v + 1, Villager.count
    assert_equal "chief", user.fjords.first.villages.first.buildings.first.villagers.first.title
  end
end
