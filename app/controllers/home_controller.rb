class HomeController < ApplicationController
  def index
    @recent_lodges = Lodge.all.where(status: 'available').order(created_at: :desc).limit(3)
    @other_lodges = Lodge.all.where(status: 'available').order(created_at: :desc).offset(3)

   # @lodges = Lodge.all.where(status: 'available')
  end
end