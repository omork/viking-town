require 'test_helper'

class ShipTest < ActiveSupport::TestCase
  test "user can have ships" do
    user = Factory(:user, :nation => Factory(:nation))
    user.fjords << Factory(:fjord, :nation => user.nation)
    user.fjords.first.ships << Factory(:ship)

    assert_equal 1, user.ships.count
  end
end
