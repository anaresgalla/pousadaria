class AddColumnsToLodges < ActiveRecord::Migration[7.1]
  def change
    add_column :lodges, :address, :string
    add_column :lodges, :neighborhood, :string
    add_column :lodges, :city, :string
    add_column :lodges, :state, :string
    add_column :lodges, :country, :string
    add_column :lodges, :zip_code, :string
  end
end
