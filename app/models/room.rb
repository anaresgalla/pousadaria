class Room < ApplicationRecord
  validates :name, :description, :area, :max_guests, :standard_overnight, presence: true
  validate :validate_pictures_content_type
  belongs_to :lodge
  has_many :special_pricings
  has_many :bookings
  has_many_attached :pictures

  def updated_standard_overnight
    special_pricing = special_pricings.find { |sp| Date.today.between?(sp.start_date, sp.end_date) }
    
    if special_pricing
      special_pricing.price
    else
      standard_overnight
    end
  end

  private

  def validate_pictures_content_type
    unless pictures.all? { |pic| pic.content_type.in?(["image/jpg", "image/jpeg", "image/png"]) }
      errors.add(:pictures, message: "Formatos permitidos: jpg, jpeg e png.")
    end
  end
end
