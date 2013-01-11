class AddGMapToVendor < ActiveRecord::Migration
  def self.up
    add_column :vendors, :latitude, :float #you can change the name, see wiki
    add_column :vendors, :longitude, :float #you can change the name, see wiki
    add_column :vendors, :gmaps, :boolean #not mandatory, see wiki
  end

  def self.down
    remove_column :vendors, :latitude
    remove_column :vendors, :longitude
    remove_column :vendors, :gmaps
  end
end
