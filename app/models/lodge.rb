class Lodge < ApplicationRecord
  validates :name, :headline, :description, :status, :disabled_facilities,
            :full_address, :phone_number, :email, :bedrooms, :max_guests,
            :check_in, :check_out, :corporate_name, :cnpj, :payment_method, :policies, presence: true

 # validates :owner_already_has_lodge, on: :create

  enum status: { available: 0, unavailable: 5}
  
  belongs_to :owner
  validates_uniqueness_of :owner_id

  def status_translation
    I18n.t("activerecord.attributes.lodge.status.#{status}")
  end

  private

  # def owner_already_has_lodge
  #   if Lodge.where(owner: self.owner).any?
  #     errors.add(:owner, 'proprietário já tem uma pousada cadastrada.')
  #   end
  # end
end
