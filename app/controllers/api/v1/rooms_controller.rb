class Api::V1::RoomsController < Api::V1::ApiController
  def index
    lodge = Lodge.find(params[:lodge_id])
    rooms = lodge.rooms.where(vacant: true)
    render status: 200, json: rooms.as_json(except: [:created_at, :updated_at])
  end
end