class AddNewCarIdColumnToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :new_car_id, :integer
  end

  def self.down
    remove_column :reviews, :new_car_id
  end
end
