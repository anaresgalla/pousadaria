class ReviewsController < ApplicationController
  before_action :set_booking, only:[:new, :create, :reply]

  def index
    if owner_signed_in? 
      @lodge = current_owner.lodge
    else
      @lodge = Lodge.find(params[:lodge_id])
    end
    @reviews = @lodge.reviews.order(created_at: :desc)
  end

  def new
    @room = @booking.room
    @lodge = @room.lodge
    @review = Review.new(booking: @booking)
  end

  def create
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
    @review = @booking.review
    @review.update(reply: params[:reply])
    redirect_to @booking, notice: 'Resposta enviada!'
  end

  private 

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :reply)
  end
end

