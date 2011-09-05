require 'test_helper'

class VillagerTest < ActiveSupport::TestCase
  test "villagers are in buildings and villages" do
    user = user_with_nation_and_fjord

    assert_equal 0, user.fjords.last.villages.count
    fjord = user.fjords.last
    village = Factory(:village, :fjord => fjord)
    assert village.save!, village.errors.inspect
    assert_equal 1, user.fjords.last.villages.count
    
    assert_equal 1, village.villagers.count
    village.villagers << Factory(:villager)
    assert_equal 2, village.villagers.count
  end
  
  test "buildings aren't created for every new villager" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    
    assert_equal 1, village.villagers.count
    assert_equal 1, village.buildings.count
    
    village.villagers << Factory(:villager)
    village.villagers << Factory(:villager)
    village.villagers << Factory(:villager)
    
    village = Village.find(village.id)
    assert_equal 1, village.buildings.count
    assert_equal 4, village.villagers.count
  end
  
  test "a villager is always assigned to the first building when created" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    
    village.buildings << TurfHouse.new
    village.buildings << TurfHouse.new
    village.buildings << TurfHouse.new
    
    th = village.buildings.first
    village.villagers << Factory(:villager)
    villager = village.villagers.last
    assert villager.building_id?
    assert_equal th.id, villager.building_id
  end
end
