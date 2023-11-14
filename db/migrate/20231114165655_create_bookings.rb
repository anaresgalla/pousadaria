class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :room, null: false, foreign_key: true
      t.date :check_in
      t.date :check_out
      t.integer :guests
      t.float :total_price

      t.timestamps
    end
  end
end
