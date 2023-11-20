class ChangeColumnTypeInBookings < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :check_in, :datetime
    change_column :bookings, :check_out, :datetime
  end
end
