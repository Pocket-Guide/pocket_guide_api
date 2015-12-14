class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :prefecture
      t.text :introduction
      t.timestamps null: false
    end
  end
end
