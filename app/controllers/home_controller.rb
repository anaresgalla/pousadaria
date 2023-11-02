class HomeController < ApplicationController
  def index
    @lodges = Lodge.all 
    #@suppliers = Supplier.all
  end
end