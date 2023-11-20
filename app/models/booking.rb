class Booking < ApplicationRecord
  before_validation :generate_code, on: :create
  validates :check_in, :check_out, :guests, presence: true #:code,
  validate :verify_number_of_guests
  validate :overlapping, on: :create
  belongs_to :room
  belongs_to :user, optional: true 
  validate :check_in_date_within_limit, on: :update
  enum status: { confirmed: 0, active: 5, completed: 10, canceled: 15 }

  def can_be_cancelled?
    return false unless check_in.is_a?(Date)

    # Convertendo check_in_date para um objeto Time considerando a meia-noite no fuso horário atual
    check_in_time = check_in.to_time.in_time_zone(Time.zone)
    check_in_time >= Time.zone.now + 7.days
  end

  private

  def check_in_date_within_limit
    return unless check_in_changed? && check_in.present? && status == :canceled
    if check_in - Time.zone.now < cancellation_limit
      errors.add(:base, 'Reservas só podem ser canceladas até 7 dias antes do check in.')
    end
  end

  def verify_number_of_guests    
    if guests.present? && room.present? && guests > room.max_guests
      errors.add(:base, 'O número de hóspedes excede a capacidade máxima do quarto.')
    end 
  end

  def overlapping
    result = true
    booked = {}
    bookings = Booking.where(status: [0, 5]).pluck(:check_in, :check_out)

    # Booking.pluck(:check_in, :check_out).each do |date_range|
    #     (date_range.first..date_range.second).each do |date| 
    #         booked[date] = true
    #     end
    #end
    
    bookings.each do |date_range|
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

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
