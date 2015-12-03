class AddChoiceToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :choice, index: true, foreign_key: true
  end
end
