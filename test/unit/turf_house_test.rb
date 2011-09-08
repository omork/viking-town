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
  end
end
