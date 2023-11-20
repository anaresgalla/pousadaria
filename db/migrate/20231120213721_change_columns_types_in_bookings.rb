class ChangeColumnsTypesInBookings < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :check_in, :date
    change_column :bookings, :check_out, :date
  end
end
