class FjordController < ApplicationController
  before_filter :user_signed_in?, :except => [:show, :list]
  
  def list
    @fjords = Fjord.page(params[:page]).order('id DESC')
  end

  def settle
    attributes = params
    attributes.delete(:controller)
    attributes.delete(:action)
    params[:nation_id] = current_user.nation_id
    current_user.fjords.create(attributes)
  end

  def abandon
  end

  def update
  end

  def show
  end
end
