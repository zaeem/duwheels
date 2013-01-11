class RemoveColumnsFromVendorsBrands < ActiveRecord::Migration
  def self.up
    remove_column :vendors_brands, :id
    remove_column :vendors_brands, :created_at
    remove_column :vendors_brands, :updated_at
  end

  def self.down
    add_column :vendors_brands, :id, :integer
    add_column :vendors_brands, :created_at, :datetime
    add_column :vendors_brands, :updated_at, :datetime
  end
end
