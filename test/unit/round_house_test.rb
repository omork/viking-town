require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  test "When a roundhouse is created, it adds one villager to the village" do
    v = Villager.count
    user = user_with_nation_and_fjord
    user.fjords.first.villages.create! :name =>'asdf'
  
    assert_equal v + 3, Villager.count
    assert_equal "chief", user.fjords.first.villages.first.buildings.first.villagers.first.title
  end
  
  test "brew and brawl" do
    user = user_with_nation_and_fjord
    user.fjords.first.villages << Factory(:village)
    building = offset_assigned_at(user.buildings.first, 5) { |b| b.allocate('brawl') }
    assert_equal 1, user.fjords.first.villages.first.resources['brawl']

    # brew produces beers
    building = offset_assigned_at(user.buildings.first, 5) { |b| b.allocate('brew') }
    assert_equal 1, user.fjords.first.villages.first.resources['beer']
  end
end
