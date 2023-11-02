class CreateLodges < ActiveRecord::Migration[7.1]
  def change
    create_table :lodges do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :state
      t.string :country
      t.string :headline

      t.timestamps
    end
  end
end
