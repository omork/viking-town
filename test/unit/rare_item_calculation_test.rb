require 'test_helper'

class RareItemCalculationTest < ActiveSupport::TestCase
  include RareItemCalculation

  def rarities ; { :rare => %w(a), :semi_precious => %w(b), :common => %w(c) } ; end
  def chances  ; { :rare => 1, :semi_precious => 1, :common => 1 } ; end
  def quantities ; return { :rare => 1..1, :semi_precious => 1..1, :common => 1..1 } ; end

  test "#chances" do
    [:rare, :semi_precious, :common].each do |key|
      chances.has_key?(key)
      assert(chances[key] > 0)
    end
  end

  test "#quantities" do
    [:rare, :semi_precious, :common].each do |key|
      assert chances.has_key?(key)
    end
  end

  test "#rarities" do
    assert_equal rarities, {:rare => %w(a), :semi_precious => %w(b), :common => %w(c)}
  end

  test "#assign_rarities!" do
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)

    assign_rarities!(village, 1000)
    %w(a b c).each do |r|
      assert_equal(village.resources[r], 1)
    end
  end

  test "opportunitities_in" do
    [500, 700, 1900, 3700, 90000].each do |times|
      assert(opportunitities_in(times) > 0)
      assert(opportunitities_in(times) < 30)
    end
  end
end

