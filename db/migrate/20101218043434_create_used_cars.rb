class CreateUsedCars < ActiveRecord::Migration
  def self.up
    create_table :used_cars do |t|
      t.string :car_plate_no
      t.string :make
      t.string :model
      t.integer :abstract_user_id
      t.integer :asking_price
      t.datetime :registration_date
      t.string :engine_capacity
      t.string :transmission
      t.string :type_of_vehicle
      t.string :fuel_type
      t.string :milage
      t.string :no_of_owners
      t.string :feature
      t.text :accessories
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :used_cars
  end
end


