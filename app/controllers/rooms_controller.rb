class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  
  def show
    
  end 

  def new
    @room = Room.new      
  end

  def create     
    @room = Room.new(room_params)
    @room.lodge = @room
    if @room.save     
      redirect_to lodge_path, notice: 'Quarto cadastrado com sucesso!'
    else 
      flash.now[:notice] = 'Quarto não cadastrado.'
      render 'new'
    end
 end

  private 

  def set_room
    @room = Room.find(params[:id])
  end
  
  def room_params
    params.require(:room).permit(:name, :description, :area, :max_guests, :standard_overnight,
                   :bathroom, :balcony, :ac, :tv, :closet, :disabled_facilities, :safe, :vacant)
  end
end