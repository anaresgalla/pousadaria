class RemoveColumnsFromLodges < ActiveRecord::Migration[7.1]
  def change
    remove_column :lodges, :full_address, :string
    remove_column :lodges, :headline, :string
  end
end
