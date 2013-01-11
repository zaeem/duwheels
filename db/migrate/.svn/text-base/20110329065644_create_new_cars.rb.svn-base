class CreateNewCars < ActiveRecord::Migration
  def self.up
    create_table :new_cars do |t|
      t.string :make
      t.string :model
      t.integer :asking_price
      t.string :engine_capacity
      t.string :transmission
      t.string :type_of_vehicle
      t.string :fuel_type
      t.string :milage
      t.string :feature
      t.text :accessories
      t.text :description
      t.integer :user_id
      t.string :model_year

      t.timestamps
    end
  end

  def self.down
    drop_table :new_cars
  end
end
