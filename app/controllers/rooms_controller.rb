class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :remove_picture]
  before_action :set_lodge, only: [:show, :new, :create]
  before_action :redirect_owner_to_lodge_registration
  
  def show
    @room = Room.all.where(lodge_id: @lodge.id).find(params[:id])
    @special_pricings = SpecialPricing.all.where(room_id: @room.id)
  end 

  def new
    @room = @lodge.rooms.new
  end

  def create       
    @room = Room.new(room_params)
    if params[:room][:pictures].present?
      @room.pictures.attach(params[:room][:pictures])
    end
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
    @room.assign_attributes(room_params) 

    if params[:room][:pictures].present?
      @room.pictures.attach(params[:room][:pictures])
    end
    if @room.save
      redirect_to lodge_room_path(@room.lodge, @room), notice: 'Quarto atualizado com sucesso!'
    else 
      flash.now[:notice] = 'Não foi possível atualizar o quarto.'
      render 'edit'
    end 
  end 

  def remove_picture
    @room.pictures.find_by(id: params[:picture_id]).purge
    redirect_to lodge_room_path(@room.lodge, @room), notice: 'Foto removida com sucesso.'
  end
 
  private 

  def room_params
    params.require(:room).permit(:name, :description, :area, :max_guests, 
                                 :standard_overnight, :bathroom, :balcony, 
                                 :ac, :tv, :closet, :disabled_facilities, 
                                 :safe, :vacant)
  end

  def set_room
    @room = Room.find(params[:id])
  end
  
  def set_lodge
    @lodge = Lodge.find(params[:lodge_id])
  end
end