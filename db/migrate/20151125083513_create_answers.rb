class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :choice
      t.timestamps null: false
    end
  end
end
