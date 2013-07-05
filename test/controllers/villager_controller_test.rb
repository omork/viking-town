require 'test_helper'

class VillagerControllerTest < ActionController::TestCase
  test "should get allocate" do
    user, village = user_and_village
    sign_in user

    get :allocate, :village_id => village.id,
      :villager_id => village.villagers.first.id,
      :building_id => village.buildings.first.id
    assert_response :success
    assert village.villagers.include?(assigns[:villager])
    assert village.buildings.include?(assigns[:building])
    assert_equal village.id, assigns[:village].id
  end
end
