class BuildingController < ApplicationController
  before_filter :user_signed_in?, :except => :show
  
  def build
  end

  def update
  end

  def show
  end

  def destroy
  end

  def task
    @building = current_user.building(params[:id])
    @building.allocate(params[:task])
    redirect_to :action => :show
  end
end
