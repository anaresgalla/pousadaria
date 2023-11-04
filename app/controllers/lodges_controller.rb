class LodgesController < ApplicationController
  def show
    @lodge = Lodge.find(params[:id])
  end 

  def new
    @lodge = Lodge.new
  end

  def create     
     @lodge = Lodge.new(lodge_params)
     if @lodge.save     
       redirect_to root_path, notice: 'Pousada cadastrada com sucesso!'
     else 
       flash.now[:notice] = 'Pousada não cadastrada.'
       render 'new'
     end
  end

  def lodge_params
    params.require(:lodge).permit(:name, :headline, :description, :status, :disabled_facilities,
                                  :full_address, :phone_number, :pets, :email, :bedrooms, :max_guests,
                                  :check_in, :check_out, :corporate_name, :cnpj, :payment_method, :policies)
  end
end