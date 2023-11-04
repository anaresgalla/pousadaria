class Lodge < ApplicationRecord

  enum status: { available: 0, unavailable: 5}
  


  def status_translation
    I18n.t("activerecord.attributes.lodge.status.#{status}")
  end
end
