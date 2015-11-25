class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.text :content
      t.timestamps null: false
    end
  end
end
