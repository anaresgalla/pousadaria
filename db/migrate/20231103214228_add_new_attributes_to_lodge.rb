class AddNewAttributesToLodge < ActiveRecord::Migration[7.1]
  def change
    add_column :lodges, :corporate_name, :string
    add_column :lodges, :cnpj, :string
    add_column :lodges, :payment_method, :text
    add_column :lodges, :policies, :text
  end
end
