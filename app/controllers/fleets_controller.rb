class FleetsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_fleet, only: [:show, :disband, :add, :remove]

  def list
    @fleets = current_user.fleets.load
  end

  def show ; end

  def assemble
    @fleet = Fleet.new(params[:fleet])

    if @fleet.save
      redirect_to url_for(action: :show,  id: @fleet.id, controller: :fleets),
                  notice: 'Fleet was successfully created.'
    else
      render action: 'new'
    end
  end

  def add
    ship = current_user.ships.find(params[:ship_id])
    @fleet.ships << ship
    redirect_to @fleet, notice: 'Ship added'
  rescue
    ship_not_found!
  end

  def remove
    ship = current_user.ships.find(params[:ship_id])
    ship.fleet_id = nil
    ship.save
    redirect_to @fleet, notice: 'Ship removed'
  rescue
    ship_not_found!
  end

  def disband
    @fleet.destroy
    redirect_to fleets_url, notice: 'Fleet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fleet
      @fleet = current_user.fleets.find(params[:id])
    end

    def ship_not_found!
      redirect_to @fleet, flash: { error: 'Ship not found' }
    end
end
