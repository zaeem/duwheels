class AddAndDropTypeColumnsFromVendors < ActiveRecord::Migration
  def self.up
    remove_column :vendors, :type
    add_column :vendors, :vendor_type, :string
  end

  def self.down
    remove_column :vendors, :vendor_type
    add_column :vendors, :type, :string
  end
end
