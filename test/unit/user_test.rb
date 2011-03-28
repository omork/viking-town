require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user can be instantiated using factory girl nation.create" do
    nation = Factory(:nation)
    assert nation.save, nation.errors.inspect
    nation.users << Factory(:user)
    assert_equal 1, nation.users.count
    assert_equal nation.id, nation.users.first.id
  end
end
