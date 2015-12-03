class RemoveChoiceFromAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :choice, :integer
  end
end
