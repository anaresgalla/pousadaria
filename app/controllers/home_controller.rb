class HomeController < ApplicationController
  def index
    @lodges = Lodge.all.where(status: 'available')
  end
end