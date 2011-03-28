require 'test_helper'

class ShipTest < ActiveSupport::TestCase
  test "user can have ships" do
    user = user_with_nation_and_fjord
    
    assert_equal 0, user.ships.count
    user.fjords.last.ships << Factory(:ship)
    assert_equal 1, user.ships.count
  end
end
