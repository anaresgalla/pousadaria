class Room < ApplicationRecord
  validates :name, :description, :area, :max_guests, :standard_overnight, presence: true
  
  belongs_to :lodge
  has_many :special_pricings
  has_many :bookings

  def updated_standard_overnight
    special_pricing = special_pricings.find { |sp| Date.today.between?(sp.start_date, sp.end_date) }
    
    if special_pricing
      special_pricing.price
    else
      standard_overnight
    end
  end
end
