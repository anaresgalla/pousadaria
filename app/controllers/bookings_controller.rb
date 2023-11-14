class BookingsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  
  def new
    @booking = Booking.new
  end  

  def create
    @booking = @room.bookings.new(booking_params)
    @booking.room = @room
    if @booking.save
      redirect_to lodge_room_path(@room.lodge, @room), notice: 'Reserva feita com sucesso!'
    else
      render :new
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :guests, :total_price)
  end
end
