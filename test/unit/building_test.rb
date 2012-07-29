require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  test "can only assign valid tasks" do
    user = user_with_nation_and_fjord
    user.fjords.first.villages << Factory(:village)
    assert_raises Building::InvalidTask do
      user.buildings.first.allocate('an invalid task')
    end
  end
  
  test "when a task is assigned timestamps are updated" do
    user = user_with_nation_and_fjord
    user.fjords.first.villages << Factory(:village)
    building = user.buildings.first
    building.allocate(Building::TASKS[building.type].last)
    assert_in_delta Time.now.to_f, building.assigned_at.to_f, 5
  end
  
  test "when a task is repeated it does it right" do
    user = user_with_nation_and_fjord
    user.fjords.first.villages << Factory(:village)
    building = user.buildings.first
    task = Building::TASKS[building.type].first
    assert_nil user.fjords.first.villages.first.resources[task]
    
    building.allocate(task)
    building.assigned_at = Time.now - 20
    building.completed_at = Time.now - 15
    building.check_task
    
    assert_equal 4, user.fjords.first.villages.first.resources[task]
  end
  
  test "buildings can't move once their initial position is set" do
    user = user_with_nation_and_fjord
    user.fjords.first.villages << Factory(:village)
    village = user.fjords.first.villages.first
    building = user.buildings.first
    
    # hex grid makes this calculation weird
    assert_equal (village.width / 2.0).ceil, building.x
    assert_equal (village.width / 2.0).floor, building.y
    
    building.x = 9001 # its over nine thousand
    building.save!
    
    building.reload
    
    # crap, it didn't work. DO IT AGAIN

    building.x = 9001 # its over nine thousand
    building.save!
    
    building.reload

    assert_equal (village.width / 2.0).ceil, building.x
  end
  
  test "verify_tasks fails if the Building class has a name collision for that task (for example: you can't mill flour and wood)" do
    Building::TASKS.merge!(:waffle_house => "syrup")
    assert_raises Building::DuplicateTask do
      Building::verify_tasks({:maple_trees => 'syrup'}.values)
    end
  end

  test "building#key respects per class constants" do
    assert_equal "mms", MeatMongerShop.new.key
  end
end
