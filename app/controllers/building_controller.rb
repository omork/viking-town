class BuildingController < ApplicationController
  before_filter :user_signed_in?, :except => :show

  def assign
    @building = current_user.building(params[:id])
    @building.allocate(params[:building][:task])
    @building.save!
    redirect_to :controller => :village, :action => :show, :id => @building.village_id
  end
  
  def build
    current_user.villages.find(params[:id]).buildings.create!(params[:building])
    redirect_to :controller => :village, :action => :show, :id => params[:id]
  end
end
