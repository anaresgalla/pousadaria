class SpecialPricingsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  before_action :redirect_owner_to_lodge_registration
   
  def new
    @special_pricing = SpecialPricing.new
  end

  def create
    @special_pricing = SpecialPricing.new(special_pricing_params)
    @special_pricing.room = @room
    if @special_pricing.save
      redirect_to lodge_room_path(@room.lodge, @room), notice: "Preço especial cadastrado com sucesso!"
    else
      render :new
    end
  end

  private

  def special_pricing_params
    params.require(:special_pricing).permit(:start_date, :end_date, :price)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end