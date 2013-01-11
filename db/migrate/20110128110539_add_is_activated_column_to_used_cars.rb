class AddIsActivatedColumnToUsedCars < ActiveRecord::Migration
  def self.up
    add_column :used_cars, :is_activated, :boolean
  end

  def self.down
    remove_column :used_cars, :is_activated
  end
end
