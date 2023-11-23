class AddActualCheckOutTimeToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :actual_check_out_time, :time
  end
end
