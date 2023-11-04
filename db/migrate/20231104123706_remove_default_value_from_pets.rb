class RemoveDefaultValueFromPets < ActiveRecord::Migration[7.1]
  def change
    change_column :lodges, :pets, :boolean, default: nil
  end
end
