class CreateSpecialPricings < ActiveRecord::Migration[7.1]
  def change
    create_table :special_pricings do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :price
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
