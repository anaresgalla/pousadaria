class RemoveAttributesFromLodge < ActiveRecord::Migration[7.1]
  def change
    remove_column :lodges, :city, :string
    remove_column :lodges, :state, :string
    remove_column :lodges, :country, :string
  end
end
