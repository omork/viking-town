require 'test_helper'

class SacrificesControllerTest < ActionController::TestCase
  setup do
    @sacrifice = Factory(:sacrifice)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sacrifices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sacrifice" do
    assert_difference('Sacrifice.count') do
      post :create, sacrifice: { god_id: @sacrifice.god_id, resources: @sacrifice.resources, village_id: @sacrifice.village_id }
    end

    assert_redirected_to sacrifice_path(assigns(:sacrifice))
  end

  test "should show sacrifice" do
    get :show, id: @sacrifice
    assert_response :success
  end
end
