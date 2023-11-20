class BookingsController < ApplicationController
  before_action :set_room, only: [:new, :create]
    
  def show
    @booking = Booking.find(params[:id])
    @room = @booking.room
    @lodge = @room.lodge
    @total_price = calculate_total_price(@room, @booking.check_in, @booking.check_out).to_f
  end 

  def new
    @booking = Booking.new
  end  

  def create
    @booking = @room.bookings.build(booking_params)
    @booking.assign_attributes(booking_params)
  
    if @booking.valid?
      session[:booking_attributes] = @booking.attributes
      redirect_to availability_lodge_room_path(@booking.room.lodge, @booking.room, @booking)
    else
      render 'new'
    end
  end
  
  def availability
    booking_attributes = session[:booking_attributes]
    @booking = Booking.new(booking_attributes)
    @room = @booking.room
    @lodge = @booking.room.lodge   
    @total_price = calculate_total_price(@room, @booking.check_in, @booking.check_out).to_f
    flash.now[:notice] = 'O quarto está disponível.'
    session[:redirect_after_sign_in] = availability_lodge_room_path(@booking.room.lodge, @booking.room, @booking)
  end  

  def confirmation
    booking_attributes = session[:booking_attributes]
    @booking = Booking.new(booking_attributes)
    @room = @booking.room
    session[:room] = @room.id
    @lodge = @booking.room.lodge   
    @total_price = calculate_total_price(@room, @booking.check_in, @booking.check_out).to_f
  end

  def save_booking
    booking_attributes = session[:booking_attributes]
    @booking = Booking.new(booking_attributes)
    @booking.user = current_user
    if @booking.save     
      redirect_to my_bookings_path, notice: 'Reserva feita com sucesso!'
    end
  end 

  def my_bookings
    @my_bookings = current_user.bookings
  end 

  def lodge_bookings
    @lodge_bookings = current_owner.lodge.bookings
  end 

  def check_in_booking
    @booking = Booking.find(params[:id])
    #@room = @booking.room
    if @booking.check_in <= Date.current
      @booking.update!(check_in: DateTime.current, status: :active)
      redirect_to lodge_bookings_path, notice: 'Check-in realizado.'
    else
      redirect_to lodge_bookings_path, notice: 'Não é possível fazer check-in'
    end
  end 

  def cancel_booking
    @booking = Booking.find(params[:id])
    @room = @booking.room
    if current_user == @booking.user
      @booking.canceled! if @booking.can_be_cancelled?
      redirect_to my_bookings_path(@booking), notice: "Reserva cancelada"
    elsif current_owner == @booking.room.lodge.owner
      @booking.canceled! if @booking.confirmed? && Date.today >= @booking.start_date + 2.days
      return redirect_to my_bookings_path(@booking), alert: "Não foi possível cancelar a reserva" unless @booking.canceled?
      redirect_to my_bookings_path(@booking), notice: "Reserva cancelada"
    else
      redirect_to my_bookings_path(@booking), alert: "Não foi possível cancelar a reserva"
    end
  end

  def active_stays
    @active_stays = current_owner.lodge.bookings.where(status: Booking.statuses[:active]).order(created_at: :desc)
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
