require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    user, village = user_and_village
    sign_in user

    get :index
    assert_redirected_to :controller => :village, :action => :show, :id => village.id
  end
end
