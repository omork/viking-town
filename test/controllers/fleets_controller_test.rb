require 'test_helper'

class FleetsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user, @village = user_and_village()
    @fleet = Factory(:fleet, user: @user, village: @village)
    sign_in @user
  end

  test "should list all fleets" do
    get :list
    assert_response :success
    assert_not_nil assigns(:fleets)
  end

  test "should assemble fleet" do
    assert_difference('Fleet.count') do
      post :assemble, fleet: {}
    end

    assert_redirected_to action: :show, id: assigns(:fleet).id
    assert flash[:notice]

    Fleet.any_instance.expects(:save).at_least_once.returns(false)
    assert_difference('Fleet.count', 0) do
      post :assemble, fleet: {}
    end
    assert_response :success
  end

  test "should show fleet" do
    get :show, id: @fleet
    assert_response :success
  end

  test "should destroy fleet" do
    assert_difference('Fleet.count', -1) do
      delete :disband, id: @fleet
    end

    assert_redirected_to fleets_path
  end

  test "add should add a ship to the fleet" do
    ship = Factory(:ship, fjord: @user.fjords.first)
    assert ship.save
    put :add, ship_id: ship.id, id: @fleet.id
    assert_redirected_to action: :show, id: assigns(:fleet).id
    assert ship.reload
    assert_equal ship.fleet, @fleet

    put :add, ship_id: 901328944943598, id: @fleet.id
    assert_redirected_to action: :show, id: assigns(:fleet).id
    assert flash[:error]
  end

  test "remove ship from fleet" do
    ship = Factory(:ship, fjord: @user.fjords.first)
    assert ship.save
    put :add, ship_id: ship.id, id: @fleet.id
    assert_redirected_to action: :show, id: assigns(:fleet).id
    delete :remove, ship_id: ship.id, id: @fleet.id
    assert_redirected_to action: :show, id: assigns(:fleet).id

    put :add, ship_id: 901328944943598, id: @fleet.id
    assert_redirected_to action: :show, id: assigns(:fleet).id
    assert flash[:error]
  end
end
