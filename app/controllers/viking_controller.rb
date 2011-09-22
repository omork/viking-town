class VikingController < ApplicationController
  before_filter :authenticate_user!, :except => :show
end
