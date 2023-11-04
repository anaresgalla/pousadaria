class AddNameToOwners < ActiveRecord::Migration[7.1]
  def change
    add_column :owners, :name, :string
  end
end
