class ReviewsController < ApplicationController

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

  private 

  def review_params
    params.require(:review).permit(:rating, :comment, :reply)
  end
end

