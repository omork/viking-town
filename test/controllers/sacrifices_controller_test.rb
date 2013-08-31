require 'test_helper'

class SacrificesControllerTest < ActionController::TestCase

  def setup
    @user, @village = user_and_village
    @village.resources['wood'] = 200
    assert @village.village_resources.save
    @sacrifice = Sacrifice.on_behalf_of(@village).these_goods(wood: 20)
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

  test "should not create sacrifice" do
    assert_difference('Sacrifice.count', 0) do
      stub_any_instance(Sacrifice, :save, false) do
        post :create, sacrifice: { god_id: @sacrifice.god_id,
                                   resources: @sacrifice.resources,
                                   village_id: @sacrifice.village_id }
      end
    end

    assert_response :success
  end

  test "should show sacrifice" do
    assert @sacrifice.save
    get :show, id: @sacrifice
    assert_response :success
  end
end
