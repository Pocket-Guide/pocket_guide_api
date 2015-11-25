class AddQuestionToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :question, index: true, foreign_key: true
  end
end
