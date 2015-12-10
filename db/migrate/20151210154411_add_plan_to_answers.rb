class AddPlanToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :plan, index: true, foreign_key: true
  end
end
