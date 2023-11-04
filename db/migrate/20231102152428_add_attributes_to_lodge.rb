class AddAttributesToLodge < ActiveRecord::Migration[7.1]
  def change
    add_column :lodges, :bedrooms, :integer
    add_column :lodges, :max_guests, :integer
    add_column :lodges, :pets, :boolean, default: true
    add_column :lodges, :disabled_facilities, :string
    add_column :lodges, :check_in, :time
    add_column :lodges, :check_out, :time
    add_column :lodges, :status, :integer, default: 0
    add_column :lodges, :email, :string
    add_column :lodges, :phone_number, :string
  end
end
