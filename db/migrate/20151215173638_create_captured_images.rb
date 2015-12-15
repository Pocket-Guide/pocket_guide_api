class CreateCapturedImages < ActiveRecord::Migration
  def change
    create_table :captured_images do |t|
      t.string :name
      t.integer :status
      t.timestamps null: false
    end
  end
end
