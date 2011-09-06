require 'test_helper'

class VillageTest < ActiveSupport::TestCase
  test "village is in a fjord" do
    user = user_with_nation_and_fjord
    
    assert_equal 0, user.fjords.last.villages.count
    user.fjords.last.villages << Factory(:village)
    assert_equal 1, user.fjords.last.villages.count
    assert !user.fjords.last.villages.last.new_record?
    assert user.fjords.last.villages.last.save
    
    assert_equal user.fjords.last.villages.last.fjord_id, user.fjords.last.id
  end
  
  test "last building is created when the village is founded" do
    user = user_with_nation_and_fjord
    user.fjords.last.villages << Factory(:village)
    
    assert_equal 1, user.fjords.last.villages.last.buildings.count
  end
end
