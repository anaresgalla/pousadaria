class BookingsController < ApplicationController
  before_action :set_room, only: [:new, :create]
  before_action :booking_attributes, only: [:availability, :confirmation, :save_booking]
  before_action :set_booking, only: [:show, :check_in_booking, :check_out_booking, :cancel_booking]
    
  def show
    @room = @booking.room
    @lodge = @room.lodge
    @total_price = calculate_special_price(@room, @booking.check_in, @booking.check_out).to_f
    @review = @booking.review
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
    @room = @booking.room
    @lodge = @booking.room.lodge   
    @total_price = calculate_special_price(@room, @booking.check_in, @booking.check_out).to_f
    flash.now[:notice] = 'O quarto está disponível.'
    session[:redirect_after_sign_in] = availability_lodge_room_path(@booking.room.lodge, @booking.room, @booking)
  end  

  def confirmation
    @room = @booking.room
    session[:room] = @room.id
    @lodge = @booking.room.lodge   
    @total_price = calculate_special_price(@room, @booking.check_in, @booking.check_out).to_f
  end

  def save_booking
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
    if @booking.check_in <= Date.current
      @booking.update!(check_in: Time.zone.now, status: :active, actual_check_in_time: Time.now.strftime('%H:%M'))
      redirect_to lodge_bookings_path, notice: 'Check-in realizado.'
    else
      redirect_to lodge_bookings_path, notice: 'Não é possível fazer check-in'
    end
  end 

  def check_out_booking
    if @booking.active?
      @booking.update!(
        check_out: Time.current,
        status: :completed,
        actual_check_out_time: Time.now.strftime('%H:%M'),
        payment_method: params[:payment_method],
        total_price: @booking.calculate_total
      )
      redirect_to @booking, notice: "Check out realizado com sucesso"
    else
      redirect_to @booking, alert: "Não foi possível realizar o check-out"
    end
  end

  def cancel_booking
    @room = @booking.room
    if current_user == @booking.user
      @booking.canceled! if @booking.can_be_cancelled?
      redirect_to my_bookings_path(@booking), notice: 'Reserva cancelada.'
    elsif current_owner == @booking.room.lodge.owner
      @booking.canceled! if @booking.confirmed? && Date.today >= @booking.check_in + 2.days
      return redirect_to lodge_bookings_path(@booking), notice: 'A reserva não foi cancelada.' unless @booking.canceled?
      redirect_to lodge_bookings_path(@booking), notice: 'Reserva cancelada.'
    else
      redirect_to lodge_bookings_path(@booking), notice: 'A reserva não pode ser cancelada.'
    end
  end

  def active_stays
    @active_stays = current_owner.lodge.bookings.where(status: Booking.statuses[:active]).order(created_at: :desc)
  end
  
  private 

  def booking_attributes
    booking_attributes = session[:booking_attributes]
    @booking = Booking.new(booking_attributes)
  end 

  def calculate_special_price(room, start_date, end_date)
    nights = (end_date - start_date).to_i
    @special_pricings = SpecialPricing.all.where(room_id: @room.id)
    special_pricing = @special_pricings.find do |sp|
      (start_date..end_date).overlaps?(sp.start_date..sp.end_date)
    end
    nightly_price = special_pricing ? special_pricing.price : room.standard_overnight.to_i
    nightly_price * nights
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
  
  def set_lodge
    @lodge = Lodge.find(params[:lodge_id])
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :guests, :payment_method, 
                                    :actual_check_out_time, :actual_check_in_time)
  end
end
