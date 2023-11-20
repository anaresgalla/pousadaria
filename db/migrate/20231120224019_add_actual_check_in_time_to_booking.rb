class AddActualCheckInTimeToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :actual_check_in_time, :time
  end
end
