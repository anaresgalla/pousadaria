class RemoveNotNullConstraintFromUserIdInBookings < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :user_id, :integer, null: true
  end
end
