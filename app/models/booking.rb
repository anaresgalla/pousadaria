class Booking < ApplicationRecord
  validates :check_in, :check_out, :guests, :total_price, presence: true
  validate :verify_number_of_guests
  belongs_to :room

  def verify_number_of_guests    
    if guests.present? && room.present? && guests > room.max_guests
      errors.add(:base, 'O número de hóspedes excede a capacidade máxima do quarto.')
    end 
  end
end
