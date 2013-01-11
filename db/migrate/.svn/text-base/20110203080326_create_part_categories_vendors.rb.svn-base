class CreatePartCategoriesVendors < ActiveRecord::Migration
  def self.up
    create_table :part_categories_vendors do |t|
      t.integer :part_category_id
      t.integer :vendor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :part_categories_vendors
  end
end
