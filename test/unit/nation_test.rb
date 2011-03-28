require 'test_helper'

class NationTest < ActiveSupport::TestCase
  test "nations have users" do
    nation = Factory(:nation)
    assert_equal 0, nation.users.count
    nation.users << Factory(:user)
    assert_equal 1, nation.users.count
  end
end
