class Booking < ApplicationRecord
  before_validation :generate_code, on: :create
  validates :check_in, :check_out, :guests, presence: true
  validate :verify_number_of_guests
  validate :overlapping, on: :create
  belongs_to :room
  belongs_to :user, optional: true 
  validate :check_in_date_within_limit, on: :update
  enum status: { confirmed: 0, active: 5, completed: 10, canceled: 15 }
  has_one :review
  
  def can_be_cancelled?
    return false unless check_in.is_a?(Date)
    check_in_time = check_in.to_time.in_time_zone(Time.zone)
    check_in_time >= Time.zone.now + 7.days
  end

  def calculate_total
    total_cost = 0
    booking_range = if check_out
                      limit = room.lodge.check_out
                      actual_check_out_time = self.actual_check_out_time || Time.current
                      range_end = (actual_check_out_time.hour >= limit.hour || (actual_check_out_time.hour == limit.hour && actual_check_out_time.min >= limit.min)) ? check_out.to_date : check_out.to_date - 1
                      check_in..range_end
                    else
                      check_in...end_date
                    end
      booking_range.each do |date|
      total_cost += room.special_pricings.find { |price| date.between?(price.start_date, price.end_date) }&.price || room.standard_overnight.to_i
    end
    total_cost
  end

  def availability(room)
    date_range = check_in..check_out
    total_price = 0
    stay_days = 0
    date_range.each do |day|
        room.special_pricings.each do |sp|
            if day.between?(sp.start_date, sp.end_date) == true
               total_price = total_price + sp.price
               stay_days += 1
            end
        end
    end
    total_regular_price = date_range.count - stay_days
    total_price = total_price + (total_regular_price.to_i * room.standard_overnight.to_i) 
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
