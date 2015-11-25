class AddTourToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :tour, index: true, foreign_key: true
  end
end
