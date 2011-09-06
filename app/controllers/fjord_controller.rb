class FjordController < ApplicationController
  before_filter :user_signed_in?, :except => [:show, :list]
  
  def list
    @fjords = Fjord.page(params[:page]).order('id DESC')
  end

  def settle
    params[:fjord][:nation_id] = current_user.nation_id
    current_user.fjords.create!(params[:fjord])
    redirect_to :action => :mine
  end

  def abandon
    @fjord = current_user.fjords.find(params[:id])
    @fjord.destroy
  end

  def update
    @fjord = current_user.fjords.find(params[:id])
    @fjord.update_attributes(params[:fjord].stringify_keys)
  end

  def show
    @fjord = current_user.fjords.find(params[:id])
  end
  
  def mine
    @fjords = current_user.fjords.page(params[:page]).order('id desc')
    render :action => :list
  end
end
