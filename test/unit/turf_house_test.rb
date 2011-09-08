require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  test "when a turf house makes hay, it makes 3 times as much straw too" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
  
    user.villages.first.buildings.create!(:type => 'TurfHouse', :x => 1, :y => 1)
    th = user.villages.first.buildings.last()
    th.allocate('hay')
    th.save!
    
    th.completed_at = Time.now
    th.assigned_at = Time.now - 5
    
    th.save!
    th = Building.find(th.id)
    
    assert_equal 3, th.village.resources['straw']
    assert_equal 1, th.village.resources['hay']
  end
  
  test "sheep cost 10 straw and 30 hay" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
  
    user.villages.first.buildings.create!(:type => 'TurfHouse', :x => 1, :y => 1)
    th = user.villages.first.buildings.last()

    village.increment_resources("hay", 10)
    village.increment_resources!("straw", 30)

    th = offset_assigned_at(th, 51) { |b| b.allocate("raise-sheep") }
    
    village.reload
    assert_equal 1, village.resources['sheep']
    assert_equal 0, village.resources['straw']
    assert_equal 0, village.resources['hay']
  end
end
