class ShipController < ApplicationController
  before_filter :user_signed_in?, :except => :show
end
