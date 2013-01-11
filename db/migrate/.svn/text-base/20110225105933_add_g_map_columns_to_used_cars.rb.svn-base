class AddGMapColumnsToUsedCars < ActiveRecord::Migration
  def self.up
    add_column :used_cars, :latitude, :float #you can change the name, see wiki
    add_column :used_cars, :longitude, :float #you can change the name, see wiki
    add_column :used_cars, :gmaps, :boolean #not mandatory, see wiki
  end

  def self.down
    remove_column :used_cars, :latitude
    remove_column :used_cars, :longitude
    remove_column :used_cars, :gmaps
  end
end
