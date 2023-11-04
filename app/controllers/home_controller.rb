class HomeController < ApplicationController
  def index
    @lodges = Lodge.all 
   
  end
end