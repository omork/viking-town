require 'test_helper'

class VikingTest < ActiveSupport::TestCase
  test "vikings can be on ships" do    
    user.fjords.first.vikings << Factory(:viking)
    viking = user.fjords.first.vikings.first
    assert viking.ship.nil?, "ship is not nil"
    assert !viking.new_record?

    assert_equal 0, user.fjords.first.ships.first.vikings.count
    user.fjords.first.ships.first.vikings << viking
    assert_equal 1, user.fjords.first.ships.first.vikings.count
  end
end
