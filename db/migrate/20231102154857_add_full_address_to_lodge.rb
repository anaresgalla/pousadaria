class AddFullAddressToLodge < ActiveRecord::Migration[7.1]
  def change
    add_column :lodges, :full_address, :string
  end
end
