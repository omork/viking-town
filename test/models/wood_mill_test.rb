require 'test_helper'

class WoodMillTest < ActiveSupport::TestCase
  test "do-task" do
    user, village = user_and_village
    village.increment_resources!('wood', 5)
    village.buildings << WoodMill.create!(:x => 1, :y => 1)
    wm = village.buildings.last
    wm = offset_assigned_at(wm, 501) { |r| r.allocate('planks') }
    village.reload
    assert_equal 2, village.resources['planks']
  end
end

