class SpecialPricing < ApplicationRecord
  validates :start_date, :end_date, :price, presence: true
  validate :dates_overlapping
  validate :check_dates
  belongs_to :room

  private

  def dates_overlapping    
    if room && start_date && end_date
      overlapping_special_pricings = room.special_pricings
                                    .where.not(id: id)
                                    .where('start_date <= ? AND end_date >= ?', end_date, start_date)
      
      if overlapping_special_pricings.any?
        errors.add(:base, 'O quarto já possui um preço especial nessa data.')
      end
    end
  end 

  def check_dates
    if room && start_date && end_date && start_date >= end_date
      errors.add(:base, 'A data informada está incorreta.')
    end
  end
end
