class BookingsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  
  def new
    @booking = Booking.new
  end  

  def create
    @booking = @room.bookings.build(booking_params)
    @booking.assign_attributes(booking_params)
  
    if @booking.valid?
      session[:booking_attributes] = @booking.attributes
      redirect_to confirmation_lodge_room_path(@booking.room.lodge, @booking.room, @booking)
    else
      render 'new'
    end
  end
  
  def confirmation
    booking_attributes = session[:booking_attributes]
    @booking = Booking.new(booking_attributes)
    @room = @booking.room
    @lodge = @booking.room.lodge   
    @total_price = calculate_total_price(@room, @booking.check_in, @booking.check_out).to_f
    flash.now[:notice] = 'O quarto está disponível.'
  end  

  private

  def calculate_total_price(room, start_date, end_date)
    nights = (end_date - start_date).to_i
    @special_pricings = SpecialPricing.all.where(room_id: @room.id)
    special_pricing = @special_pricings.find do |sp|
      (start_date..end_date).overlaps?(sp.start_date..sp.end_date)
    end
    nightly_price = special_pricing ? special_pricing.price : room.standard_overnight.to_i
    nightly_price * nights
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
  
  def set_lodge
    @lodge = Lodge.find(params[:lodge_id])
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :guests)
  end
end
