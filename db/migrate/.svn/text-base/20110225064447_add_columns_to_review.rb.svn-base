class AddColumnsToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :user_id, :integer
    add_column :reviews, :used_car_id, :integer
    add_column :reviews, :vendor_id, :integer
  end

  def self.down
    remove_column :reviews, :user_id
    remove_column :reviews, :used_car_id
    remove_column :reviews, :vendor_id
  end
end
