require 'test_helper'

class FleetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "docked_at?" do
    user, village = user_and_village
    user.fjords.first.ships << Factory(:ship)
    ship = user.ships.last
    assert ship.save
    user.fleets << Factory(:fleet)
    user.fleets.first.ships << ship
    assert user.fleets.first.dock_at!(village)
    assert_not_nil user.fleets.first.docked_at
    assert user.fleets.first.docked?
  end
end
