require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/mock'
require 'factory_girl'

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

  def user_and_fleet
    user = user_with_nation_and_fjord
    fleet = user.fleets.create!
    return user, fleet
  end
end

def stub_any_instance(klass, method, value)
  klass.class_eval do
    alias_method :"new_#{method}", method

    define_method(method) do
      if value.respond_to?(:call)
        value.call
      else
        value
      end
    end
  end

  yield
ensure
  klass.class_eval do
    undef_method method
    alias_method method, :"new_#{method}"
    undef_method :"new_#{method}"
  end
end

