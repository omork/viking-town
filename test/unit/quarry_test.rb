require 'test_helper'

class QuarryTest < ActiveSupport::TestCase
  test "only one quarry per village" do
    user, village = user_and_village
    village.buildings << Quarry.new(:x => 1, :y => 1)
    assert village.save
    village.buildings << Quarry.new(:x => 2, :y => 1)
    assert !village.save
  end

  test "quarries over time cut deeper shafts" do
    user, village = user_and_village
    village.buildings << Quarry.new(:x => 1, :y => 1)
    quarry = village.buildings.last

    offset_assigned_at(quarry, 500) { |q| q.allocate('cut-shaft') }
    village.reload
    assert_equal 100, village.resources['shaft-depth']
  end

  test "get stoned" do
    user, village = user_and_village
    village.buildings << Quarry.new(:x => 1, :y => 1)
    quarry = village.buildings.last

    offset_assigned_at(quarry, 500) { |q| q.allocate('quarry-stone') }
    village.reload
    assert_equal 100, village.resources['stone']
  end

end
