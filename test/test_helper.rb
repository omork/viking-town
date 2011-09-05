ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl'

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActiveSupport::TestCase
  include FactoryGirl
  
  def user_with_nation_and_fjord
    user = Factory(:user, :nation => Factory(:nation))
    user.fjords << Factory(:fjord, :nation => user.nation)
    user
  end
  
  def village_with_single_villager_for_user(user)
    user.fjords.last.villages << Factory(:village)
    assert_equal 1, user.fjords.last.villages.count
    village = user.fjords.last.villages.last
    assert_equal 1, village.villagers.count
    village
  end
end