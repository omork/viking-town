require 'test_helper'

class BlacksmithTest < ActiveSupport::TestCase
  def preload_resources(village)
    %w(coal planks wrought-iron copper iron iron-ingots).each do |resource|
      village.increment_resources!(resource, 10)
    end
    village
  end

  def setup_user_and_village_with_blacksmith
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    village.buildings << Blacksmith.create!(:x => 1, :y => 1)
    village = preload_resources(village)
    return user, village
  end

  test "manufacturables consume the correct amount of resources" do
    user, village = setup_user_and_village_with_blacksmith
    blacksmith = village.buildings.last

    blacksmith.manufacturables.each do |item, resources|
      village.village_resources.resources = {}
      village = preload_resources(village)

      blacksmith = offset_assigned_at(blacksmith, 501) { |bs| bs.allocate(item) }
      village.reload
      needs = %w(coal planks wrought-iron copper).zip(resources)
      needs.each do |need, value|
        assert_equal 10 - value, village.resources[need], "#{need} : #{item}"
      end

      assert_equal 1, village.resources[item], item
    end
  end

  test "smelting consumes coal and produces ingots" do
    user, village = setup_user_and_village_with_blacksmith
    blacksmith = offset_assigned_at(village.buildings.last, 501) { |bs| bs.allocate('smelt') }
    village.reload
    assert_equal 9, village.resources['coal']
    assert_equal 8, village.resources['iron']
    assert_equal 12, village.resources['iron-ingots']
  end

  test "wrought'ing consumes coal and ingots and produces wrought-iron" do
    user, village = setup_user_and_village_with_blacksmith
    blacksmith = offset_assigned_at(village.buildings.last, 501) { |bs| bs.allocate('wrought') }
    village.reload
    assert_equal 9, village.resources['coal']
    assert_equal 9, village.resources['iron-ingots']
    assert_equal 11, village.resources['wrought-iron']
  end
end
