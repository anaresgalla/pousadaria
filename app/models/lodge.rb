class Lodge < ApplicationRecord
  validates :name, :description, :status, :disabled_facilities, :address, :city, 
            :state, :country, :zip_code, :phone_number, :email, :bedrooms, 
            :max_guests, :check_in, :check_out, :corporate_name, :cnpj, 
            :payment_method, :policies, presence: true
  validate :validate_pictures_content_type

  enum status: { Ativa: 0, Inativa: 5 }
  
  belongs_to :owner
  has_many :rooms
  validates_uniqueness_of :owner_id
  has_many :bookings, through: :rooms
  has_many :reviews, through: :bookings
  has_many_attached :pictures

  def status_translation
    I18n.t("activerecord.attributes.lodge.status.#{status}")
  end

  def average
    bookings.joins(:review).average('rating')&.round(1)
  end

  def generate_show_json 
    average = self.average.to_f
    average = '' if average == 0.0
    attributes.except('cnpj', 'corporate_name', 'owner_id', 'created_at', 'updated_at')
              .merge(average: average)
  end

  private

  def validate_pictures_content_type
    unless pictures.all? { |pic| pic.content_type.in?(["image/jpg", "image/jpeg", "image/png"]) }
      errors.add(:pictures, message: "Formatos permitidos: jpg, jpeg e png.")
    end
  end
end
