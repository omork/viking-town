class ShipController < ApplicationController
  before_filter :user_signed_in? :except => :show
  
  def show
  end

  def update
  end

  def scuttle
  end

  def build
  end

end
