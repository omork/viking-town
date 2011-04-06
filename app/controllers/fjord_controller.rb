class FjordController < ApplicationController
  before_filter :user_signed_in? :except => [:show, :list]
  
  def list
  end

  def settle
  end

  def abandon
  end

  def update
  end

  def show
  end
end
