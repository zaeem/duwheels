class AddModelYearColumnToUsedCars < ActiveRecord::Migration
  def self.up
    add_column :used_cars, :model_year, :string
  end

  def self.down
    remove_column :used_cars, :model_year
  end
end
