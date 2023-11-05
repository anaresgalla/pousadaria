class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.string :area
      t.integer :max_guests
      t.string :standard_overnight
      t.boolean :bathroom
      t.boolean :balcony
      t.boolean :ac
      t.boolean :tv
      t.boolean :closet
      t.boolean :disabled_facilities
      t.boolean :safe
      t.boolean :vacant

      t.timestamps
    end
  end
end
