class BuildingController < ApplicationController
  before_filter :user_signed_in? :except => :show
  
  def build
  end

  def update
  end

  def show
  end

  def destroy
  end

end
