class AddColumnToRooms < ActiveRecord::Migration[7.1]
  def change
    add_reference :rooms, :lodge, null: false, foreign_key: true
  end
end
