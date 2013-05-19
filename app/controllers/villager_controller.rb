class VillagerController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  
  def allocate
    @village  = current_user.villages.find(params[:village_id])
    @villager = @village.villagers.find(params[:villager_id])
    @building = current_user.building(params[:building_id])
  end
end
