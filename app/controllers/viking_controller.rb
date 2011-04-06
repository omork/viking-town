class VikingController < ApplicationController
  before_filter :user_signed_in? :except => :show
  
  def allocate
  end

  def show
  end

  def update
  end

  def rename
  end

end
