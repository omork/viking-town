require 'test_helper'

class VillageResourcesTest < ActiveSupport::TestCase
  test "empty resources is created when village is created" do
    user, village = user_and_village
    assert_equal Hash.new, village.resources
    
    # make sure the delegate is doing what we expect too
    assert_equal Hash.new, user.fjords.last.villages.first.resources
  end

  test "take!" do
    user, village = user_and_village
    village.resources['wood'] = 20
    village.village_resources.take! 'wood', 2, 10
    assert_equal village.resources['wood'], 0

    village.resources['wood'] = 5
    village.village_resources.take! 'wood', 2, 10
    assert_equal 1, village.resources['wood']
  end

  test "take_these!" do
    user, village = user_and_village
    village.resources['wood'] = 20
    village.resources['coal'] = 20
    assert village.village_resources.save!
    village = Village.find(village.id)
    village.village_resources.take_these!([['wood', 2, 10], ['coal', 2, 10]])
    assert_equal village.resources['wood'], 0
    assert_equal village.resources['coal'], 0

    village = Village.find(village.id)
    village.resources['wood'] = 20
    village.resources['coal'] = 20
    assert village.village_resources.save!
    village.village_resources.take_these!([['wood', 3, 10], ['coal', 2, 10]])
    village = Village.find(village.id)
    assert_equal village.resources['wood'], 20
    assert_equal village.resources['coal'], 20
  end
end
