class AddUserIdColumnToUsedCars < ActiveRecord::Migration
  def self.up
    add_column :used_cars, :user_id, :integer
  end

  def self.down
    remove_column :used_cars, :user_id
  end
end
