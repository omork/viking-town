require 'test_helper'

class VikingTest < ActiveSupport::TestCase
  test "vikings can be on ships" do    
    user = Factory(:user, :nation => Factory(:nation))
    user.fjords << Factory(:fjord, :nation => user.nation)
    user.fjords.first.vikings << Factory(:viking)
    viking = user.fjords.first.vikings.first
    assert viking.ship.nil?, "ship is not nil"
    assert !viking.new_record?
    user.fjords.first.ships << Factory(:ship)

    assert_equal 0, user.fjords.first.ships.first.vikings.count
    user.fjords.first.ships.first.vikings << viking
    assert_equal 1, user.fjords.first.ships.first.vikings.count
  end
end
