class VillageController < ApplicationController
  before_filter :user_signed_in? :except => :show
  
  def found
  end

  def abandon
  end

  def update
  end

  def show
  end

end
