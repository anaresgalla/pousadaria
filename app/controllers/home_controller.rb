class HomeController < ApplicationController
  before_action :redirect_owner_to_lodge_registration
  
  def index
    @recent_lodges = Lodge.all.where(status: 'Ativa').order(created_at: :desc).limit(3)
    @other_lodges = Lodge.all.where(status: 'Ativa').order(created_at: :desc).offset(3)
  end

  def search
    @lodges = Lodge.where('name like ? OR neighborhood like ? OR city like ?',
                        "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
                   .order :name
  end
end