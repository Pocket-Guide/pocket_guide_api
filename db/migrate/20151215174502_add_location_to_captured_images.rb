class AddLocationToCapturedImages < ActiveRecord::Migration
  def change
    add_reference :captured_images, :location, index: true, foreign_key: true
  end
end
