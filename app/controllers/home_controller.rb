class HomeController < ApplicationController
  def index
    @recent_lodges = Lodge.all.where(status: 'available').order(created_at: :desc).limit(3)
    @other_lodges = Lodge.all.where(status: 'available').order(created_at: :desc).offset(3)
  end

  def search
    @lodges = Lodge.where('name like ? OR neighborhood like ? OR city like ?',
                        "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
  end
end