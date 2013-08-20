require 'test_helper'

class SacrificeTest < ActiveSupport::TestCase
  def setup
    @user, @village = user_and_village
    @village.resources['wood'] = 200
    assert @village.village_resources.save
  end

  test "take_resources_from_village gets all of them" do
    sacrifice = Sacrifice.on_behalf_of(@village).these_goods(wood: 20)
    assert sacrifice.save!
    @village.reload
    assert @village.resources['wood'] == 180
  end

  test "take_resources_from_village doesn't let the sacrifice save if there aren't enough resources" do
    sacrifice = Sacrifice.on_behalf_of(@village).these_goods(wood: 400)
    assert sacrifice.save == false
    @village.reload
    assert @village.resources['wood'] == 200
  end

  test "try to take goods which are not a hash" do
    assert_raises(ArgumentError) do
      Sacrifice.on_behalf_of(@village).these_goods(:not_a_hash)
    end
  end
end
