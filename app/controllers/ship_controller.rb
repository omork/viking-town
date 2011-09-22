class ShipController < ApplicationController
  before_filter :authenticate_user!, :except => :show
end
