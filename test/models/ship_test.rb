require 'test_helper'

class ShipTest < ActiveSupport::TestCase
  test "user can have ships" do
    user, fleet = user_and_fleet
    
    assert_difference('user.ships.count') do
      ship = Factory(:ship)
      assert ship.save
      user.fjords.last.ships << ship
    end
  end
end
