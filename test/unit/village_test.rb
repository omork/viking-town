require 'test_helper'

class VillageTest < ActiveSupport::TestCase
  test "village is in a fjord" do
    user = Factory(:user, :nation => Factory(:nation))
    user.fjords << Factory(:fjord, :nation => user.nation)
    
    assert_equal 0, user.fjords.first.villages.count
    user.fjords.first.villages << Factory(:village)
    assert_equal 1, user.fjords.first.villages.count
    assert !user.fjords.first.villages.first.new_record?
    assert user.fjords.first.villages.first.save
    
    assert_equal user.fjords.first.villages.first.fjord_id, user.fjords.first.id
  end
end
