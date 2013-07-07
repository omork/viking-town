class SacrificesController < ApplicationController
  before_action :set_sacrifice, only: [:show, :edit, :update, :destroy]

  # GET /sacrifices
  def index
    @sacrifices = Sacrifice.page(params[:page]).order('id DESC')
  end

  # GET /sacrifices/1
  def show
  end

  # GET /sacrifices/new
  def new
    @sacrifice = Sacrifice.new
  end

  # POST /sacrifices
  def create
    @sacrifice = Sacrifice.new(sacrifice_params)

    if @sacrifice.save
      redirect_to @sacrifice, notice: 'Sacrifice was successfully created.'
    else
      render action: 'new'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sacrifice
      @sacrifice = Sacrifice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sacrifice_params
      params.require(:sacrifice).permit(:resources, :god_id, :village_id)
    end
end
