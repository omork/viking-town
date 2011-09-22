class VillagerController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  
  def allocate
    @villager = current_user.villagers.find(params[:villager_id])
    @building = current_user.building(params[:building_id])
    @building.allocate
  end
end
