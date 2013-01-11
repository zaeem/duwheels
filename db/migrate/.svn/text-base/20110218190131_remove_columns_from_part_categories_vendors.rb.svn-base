class RemoveColumnsFromPartCategoriesVendors < ActiveRecord::Migration
  def self.up
    remove_column :part_categories_vendors, :id
    remove_column :part_categories_vendors, :created_at
    remove_column :part_categories_vendors, :updated_at
  end

  def self.down
    add_column :part_categories_vendors, :id, :integer
    add_column :part_categories_vendors, :created_at, :datetime
    add_column :part_categories_vendors, :updated_at, :datetime
  end
end
