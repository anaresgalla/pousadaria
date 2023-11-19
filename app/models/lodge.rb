class Lodge < ApplicationRecord
  validates :name, :description, :status, :disabled_facilities, :address, :city, 
            :state, :country, :zip_code, :phone_number, :email, :bedrooms, 
            :max_guests, :check_in, :check_out, :corporate_name, :cnpj, 
            :payment_method, :policies, presence: true

  enum status: { Ativa: 0, Inativa: 5 }
  
  belongs_to :owner
  has_many :rooms
  validates_uniqueness_of :owner_id
  has_many :bookings, through: :rooms


  def status_translation
    I18n.t("activerecord.attributes.lodge.status.#{status}")
  end
end
