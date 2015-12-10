class AddTouristToPlans < ActiveRecord::Migration
  def change
    add_reference :plans, :tourist, index: true, foreign_key: true
  end
end
