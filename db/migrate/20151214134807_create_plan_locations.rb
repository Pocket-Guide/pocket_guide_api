class CreatePlanLocations < ActiveRecord::Migration
  def change
    create_table :plan_locations do |t|
      t.integer :plan_id
      t.integer :location_id
    end
  end
end
