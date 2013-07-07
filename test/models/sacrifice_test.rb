require 'test_helper'

class SacrificeTest < ActiveSupport::TestCase
  def setup_sacrifice
    user, village = user_and_village
    village.resources['wood'] = 200
    assert village.village_resources.save
    sacrifice = Sacrifice.on_behalf_of(village).these_goods(wood: 20)
  end

  test "take_resources_from_village gets all of them" do
    setup_sacrifice
    assert sacrifice.save!
    village.reload
    assert village.resources['wood'] == 180
  end

  test "take_resources_from_village doesn't let the sacrifice save if there aren't enough resources" do
    setup_sacrifice
    assert sacrifice.save == false
    village.reload
    assert village.resources['wood'] == 200
  end
end
