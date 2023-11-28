class ReviewsController < ApplicationController

  def index
    if owner_signed_in? 
      @lodge = current_owner.lodge
    else
      @lodge = Lodge.find(params[:lodge_id])
    end
    @reviews = @lodge.reviews.order(created_at: :desc)
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @room = @booking.room
    @lodge = @room.lodge
    @review = Review.new(booking: @booking)
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.booking = @booking

    if @review.save
      redirect_to @booking, notice: 'Avaliação enviada com sucesso.'
    else
      @lodge = @booking.room.lodge
      flash.now[:alert] = 'Não foi possível registrar a avaliação.'
      render :new
    end
  end

  def reply
    @booking = Booking.find(params[:booking_id])
    @review = @booking.review
    @review.update(reply: params[:reply])
    redirect_to @booking, notice: 'Resposta enviada!'
  end

  private 

  def review_params
    params.require(:review).permit(:rating, :comment, :reply)
  end
end

