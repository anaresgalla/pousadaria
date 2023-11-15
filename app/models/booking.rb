class Booking < ApplicationRecord
  validates :check_in, :check_out, :guests, presence: true
  validate :verify_number_of_guests
  validate :overlapping
  belongs_to :room

  private

  def verify_number_of_guests    
    if guests.present? && room.present? && guests > room.max_guests
      errors.add(:base, 'O número de hóspedes excede a capacidade máxima do quarto.')
    end 
  end

  def overlapping
    result = true
    booked = {}

    Booking.pluck(:check_in, :check_out).each do |date_range|
        (date_range.first..date_range.second).each do |date| 
            booked[date] = true
        end
    end

    if booked.has_key? self.check_in
        errors.add(:base, 'O quarto não está disponível na data de entrada.')
        result = false
    end

    if booked.has_key? self.check_out
        errors.add(:base, 'O quarto não está disponível na data de saída.')
        result = false
    end
    result
  end
end
