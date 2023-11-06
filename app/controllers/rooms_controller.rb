class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  
  def show
  end 

  def new
    @lodge = Lodge.find(params[:lodge_id])
    @room = @lodge.rooms.new
  end

  def create   
    @lodge = Lodge.find_by(owner_id: current_owner.id)  
    @room = Room.new(room_params)
    @room.lodge = @lodge
    if @room.save     
      redirect_to lodge_room_path(@lodge, @room), notice: 'Quarto cadastrado com sucesso!'
    else 
      flash.now[:notice] = 'Quarto não cadastrado.'
      render 'new'
    end
 end 

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to lodge_room_path(@room.id), notice: 'Quarto atualizado com sucesso!'
    else 
      flash.now[:notice] = 'Não foi possível atualizar o quarto.'
      render 'edit'
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