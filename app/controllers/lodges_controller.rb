class LodgesController < ApplicationController
  before_action :set_lodge, only: [:show, :edit, :update, :remove_picture]
  before_action :redirect_owner_to_lodge_registration, only: [:show, :edit, :update]
 
  def show
    @rooms = @lodge.rooms.where(vacant: true)
    @average_rating = @lodge.average
    @recent_reviews = @lodge.reviews.order(created_at: :desc).limit(3)
  end 

  def new 
    @lodge = Lodge.new      
  end

  def create     
    @lodge = Lodge.new(lodge_params)
    if params[:lodge][:pictures].present?
      @lodge.pictures.attach(params[:lodge][:pictures])
    end
    @lodge.owner = current_owner
    if @lodge.save     
      redirect_to root_path, notice: 'Pousada cadastrada com sucesso!'
    else 
      flash.now[:notice] = 'Pousada não cadastrada.'
      render 'new'
    end
  end

  def edit 
  end

  def update
    @lodge.assign_attributes(lodge_params) 
    if params[:lodge][:pictures].present?
      @lodge.pictures.attach(params[:lodge][:pictures])
    end
    if @lodge.save
      redirect_to lodge_path(@lodge.id), notice: 'Pousada atualizada com sucesso!'
    else 
      flash.now[:notice] = 'Não foi possível atualizar a pousada.'
      render 'edit'
    end
  end 

  def city
    @city = params[:city]
    lodge_city = Lodge.where(city: @city).pluck(:city)
    @available_lodges = Lodge.where(status: 'Ativa').where(city: lodge_city).order(:name)
  end

  def remove_picture
    @lodge.pictures.find_by(id: params[:picture_id]).purge
    redirect_to lodge_path(@lodge.id), notice: 'Foto removida com sucesso.'
  end

  private 

  def set_lodge
    @lodge = Lodge.find(params[:id])
  end

  def lodge_params
    params.require(:lodge).permit(:name, :description, :status, :disabled_facilities, 
                                  :address, :neighborhood, :city, :state, :country,
                                  :zip_code, :phone_number, :pets, :email, :bedrooms, 
                                  :max_guests, :check_in, :check_out, :corporate_name, 
                                  :cnpj, :payment_method, :policies)
  end
end
