class Api::V1::LodgesController < Api::V1::ApiController
   
  def index
    if params[:name]
      lodges = Lodge.Ativa.where("name LIKE ?", "%#{params[:name]}%")
    else
      lodges = Lodge.Ativa
    end
    render status: 200, json: lodges.as_json(except: [:owner_id, :created_at, :updated_at])   
  end

  def show
    lodge = Lodge.find(params[:id])   
    lodge_json = lodge.generate_show_json
    render status: 200, json: lodge_json
  end

  def check_availability
    room = Room.find(params[:id])
    #booking = Booking.new
    booking = Booking.new(check_in: params[:start_date],
                          check_out: params[:end_date],
                          guests: params[:guests],
                          room_id: room.id)
    if booking.valid?
      booking.total_price = booking.availability(room)
      return render status: 200, json: booking.as_json(only: [:total_price])
    else
      render status: 422, json: { error: 'Reserva não pode ser feita. Data indisponível ou número de hóspedes é maior que o máximo.' }
    end
  end
end