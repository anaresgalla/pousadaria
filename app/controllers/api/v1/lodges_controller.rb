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
end