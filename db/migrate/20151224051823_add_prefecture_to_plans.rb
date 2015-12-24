class AddPrefectureToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :prefecture, :integer
  end
end
