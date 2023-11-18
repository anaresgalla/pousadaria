class AddCodeToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :code, :string
  end
end
