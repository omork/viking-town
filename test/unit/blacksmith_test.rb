require 'test_helper'

class BlacksmithTest < ActiveSupport::TestCase
  test "" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    
    village.buildings << Blacksmith.create!(:x => 1, :y => 1)

    # preload a bunch of resources
    %w(coal planks wrought-iron copper).each do |resource|
      village.increment_resources!(resource, 10)
    end

    blacksmith = offset_assigned_at(village.buildings.last, 51) { |bs| bs.allocate('sword') }
    village.reload
    assert_equal 0, village.resources['wrought-iron']
    assert_equal 1, village.resources['sword']
  end
end

