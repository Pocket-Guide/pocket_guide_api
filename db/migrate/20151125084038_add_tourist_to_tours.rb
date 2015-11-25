class AddTouristToTours < ActiveRecord::Migration
  def change
    add_reference :tours, :tourist, index: true, foreign_key: true
  end
end
