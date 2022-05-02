class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :district
      t.string :street
      t.integer :bedrooms
      t.integer :bathrooms
      t.date :availabitly
      t.float :price

      t.timestamps
    end
  end
end
