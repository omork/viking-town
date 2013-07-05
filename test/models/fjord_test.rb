require 'test_helper'

class FjordTest < ActiveSupport::TestCase
  test "settling a fjord works with user.fjords association" do
    user = Factory(:user, :nation => Factory(:nation))
    user.fjords << Factory(:fjord, :nation => user.nation)
    assert_equal 1, user.fjords.count
    assert !user.fjords.first.new_record?
    
    # double check our ids lined up
    assert_equal user.fjords.first.nation.id, user.nation.id
    assert_equal user.fjords.first.user.id, user.id
  end
  
  test "fjords have ships" do
    user = Factory(:user, :nation => Factory(:nation))
    fjord = Factory(:fjord, :nation => user.nation, :user => user)
    fjord.ships << Factory(:ship)
    
    assert_equal 1, fjord.ships.count
    assert_equal 1, user.fjords.first.ships.count
  end
end
