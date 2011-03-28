require 'test_helper'

class VikingTest < ActiveSupport::TestCase
  test "vikings can be on ships" do    
    user = user_with_nation_and_fjord
    user.fjords.last.vikings << Factory(:viking)
    viking = user.fjords.last.vikings.last
    assert viking.ship.nil?, "ship is not nil"
    assert !viking.new_record?
    user.fjords.last.ships << Factory(:ship)

    assert_equal 0, user.fjords.last.ships.last.vikings.count
    user.fjords.last.ships.last.vikings << viking
    assert_equal 1, user.fjords.last.ships.last.vikings.count
  end
end
