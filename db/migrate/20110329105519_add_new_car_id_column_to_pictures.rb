class AddNewCarIdColumnToPictures < ActiveRecord::Migration

  def self.up
    add_column :pictures, :new_car_id, :integer
  end

  def self.down
    remove_column :pictures, :new_car_id
  end

end
