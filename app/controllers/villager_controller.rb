class VillagerController < ApplicationController
  before_filter :user_signed_in?, :except => :show
  
  def allocate
    @villager = current_user.villagers.find(params[:villager_id])
    @building = current_user.building(params[:building_id])
    @building.allocate
  end
end
