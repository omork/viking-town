require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user can be instantiated using factory girl nation.create" do
    nation = Factory(:nation)
    assert nation.save, nation.errors.inspect
    nation.users << Factory(:user)
    assert_equal 1, nation.users.count
    assert_equal nation.id, nation.users.first.id
  end
  
  test "user can find their own buildings but not someone else's" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    
    user.buildings.each do |building|
      assert village.buildings.include?(building)
    end
    
    assert user.building(village.buildings.first.id)
    
    newuser = user_with_nation_and_fjord
    newvillage = village_with_single_villager_for_user(newuser)

    assert_nil user.building(newvillage.buildings.first.id)
  end
end
