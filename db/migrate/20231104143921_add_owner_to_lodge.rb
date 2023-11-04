class AddOwnerToLodge < ActiveRecord::Migration[7.1]
  def change
    add_reference :lodges, :owner, null: false, foreign_key: true
  end
end
