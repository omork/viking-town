class VillageController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  
  def found
    fjord = current_user.fjords.find(params[:village][:fjord_id])
    village = fjord.villages.create!(params[:village])
    redirect_to :action => :show, :id => village.id
  end

  def abandon
    @village = current_user.villages.find(params[:id])
    @village.destroy
  end

  def update
    @village = current_user.villages.find(params[:id])
    @village.update_attributes(params[:village].stringify_keys)
  end

  def show
    @village = Village.find(params[:id])
  end
end
