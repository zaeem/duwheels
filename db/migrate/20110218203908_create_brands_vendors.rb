class CreateBrandsVendors < ActiveRecord::Migration
  def self.up
    create_table :brands_vendors do |t|
      t.integer :brand_id
      t.integer :vendor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :brands_vendors
  end
end
