class Lodge < ApplicationRecord
  validates :name, :headline, :description, :status, :disabled_facilities,
            :full_address, :phone_number, :email, :bedrooms, :max_guests,
            :check_in, :check_out, :corporate_name, :cnpj, :payment_method, :policies, presence: true

  enum status: { available: 0, unavailable: 5}
  
  belongs_to :owner
  validates_uniqueness_of :owner_id

  def status_translation
    I18n.t("activerecord.attributes.lodge.status.#{status}")
  end
end
