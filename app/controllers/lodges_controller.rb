class LodgesController < ApplicationController
  before_action :set_lodge, only: [:show, :edit, :update]
 
  def show
    @lodge = Lodge.find(params[:id])
    @rooms = @lodge.rooms
  end 

  def new 
    @lodge = Lodge.new      
  end

  def create     
     @lodge = Lodge.new(lodge_params)
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
    if @lodge.update(lodge_params)
      redirect_to lodge_path(@lodge.id), notice: 'Pousada atualizada com sucesso!'
    else 
      flash.now[:notice] = 'Não foi possível atualizar a pousada.'
      render 'edit'
    end 
  end 

  private 

  def set_lodge
    @lodge = Lodge.find(params[:id])
  end

  def lodge_params
    params.require(:lodge).permit(:name, :headline, :description, :status, :disabled_facilities,
                                  :full_address, :phone_number, :pets, :email, :bedrooms, :max_guests,
                                  :check_in, :check_out, :corporate_name, :cnpj, :payment_method, :policies)
  end
end