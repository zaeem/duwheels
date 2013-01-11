class RemoveColumnsFromBrandsVendors < ActiveRecord::Migration
  def self.up
    remove_column :brands_vendors, :id
    remove_column :brands_vendors, :created_at
    remove_column :brands_vendors, :updated_at
  end

  def self.down
    add_column :brands_vendors, :id, :integer
    add_column :brands_vendors, :created_at, :datetime
    add_column :brands_vendors, :updated_at, :datetime
  end
end
