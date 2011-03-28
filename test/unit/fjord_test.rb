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
end
