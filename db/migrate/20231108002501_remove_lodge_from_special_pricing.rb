class RemoveLodgeFromSpecialPricing < ActiveRecord::Migration[7.1]
  def change
    remove_reference :special_pricings, :lodge, null: false, foreign_key: true
  end
end
