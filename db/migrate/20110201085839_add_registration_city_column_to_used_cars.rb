class AddRegistrationCityColumnToUsedCars < ActiveRecord::Migration
  def self.up
    add_column :used_cars, :registration_city, :string
  end

  def self.down
    remove_column :used_cars, :registration_city
  end
end
