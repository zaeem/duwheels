class DropTableVendorsBrands < ActiveRecord::Migration
  def self.up
    drop_table :vendors_brands
  end

  def self.down
    create_table :vendors_brands do |t|
      t.integer :brand_id
      t.integer :vendor_id

      t.timestamps
    end
  end
  
end
