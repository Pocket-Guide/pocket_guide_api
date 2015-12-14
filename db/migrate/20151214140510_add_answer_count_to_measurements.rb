class AddAnswerCountToMeasurements < ActiveRecord::Migration

  def self.up

    add_column :measurements, :answer_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :measurements, :answer_count

  end

end
