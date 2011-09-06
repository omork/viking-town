require 'test_helper'

class VillageResourcesTest < ActiveSupport::TestCase
  test "empty resources is created when village is created" do
    user = user_with_nation_and_fjord
    user.fjords.last.villages << Factory(:village)
    
    assert_equal Hash.new, user.fjords.last.villages.first.village_resources.resources
    
    # make sure the delegate is doing what we expect too
    assert_equal Hash.new, user.fjords.last.villages.first.resources
  end
end
