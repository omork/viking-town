require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl'
require 'mocha'

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActiveSupport::TestCase
  include FactoryGirl

  God.load_from_file('gods.txt')

  def user_with_nation_and_fjord
    user = Factory(:user, :nation => Factory(:nation))
    user.fjords << Factory(:fjord, :nation => user.nation)
    user
  end
  
  def village_with_single_villager_for_user(user)
    user.fjords.last.villages << Factory(:village)
    assert_equal 1, user.fjords.last.villages.count
    village = user.fjords.last.villages.last
    village.villagers << Factory(:villager)
    assert_equal 1, user.fjords.last.villages.last.villagers.count
    village
  end
  
  def offset_assigned_at(building, duration)
    yield building
    building.completed_at = Time.now
    building.assigned_at  = duration.seconds.ago
    assert building.save!
    return Building.find(building.id)
  end

  def user_and_village
    user = user_with_nation_and_fjord
    village = village_with_single_villager_for_user(user)
    return user,village
  end
end
