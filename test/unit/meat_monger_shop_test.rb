require 'test_helper'

class MeatMongerShopTest < ActiveSupport::TestCase
  test "when a meant man slaughters we get delights" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)

    village.increment_resources! 'sheep', 1
    
    village.buildings << MeatMongerShop.create!(:x => 1, :y => 1)
    mms = offset_assigned_at(village.buildings.last, 5) { |b| b.allocate('slaughter-sheep') }
    village.reload
    assert_equal 0, village.resources['sheep']
  end
end
