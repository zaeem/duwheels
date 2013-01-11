class RemovePaperClipFromUsedCar < ActiveRecord::Migration
  def self.up
    remove_column :used_cars, :photo_file_name
    remove_column :used_cars, :photo_content_type
    remove_column :used_cars, :photo_file_size
  end

  def self.down
    add_column :used_cars, :photo_file_name, :string # Original filename
    add_column :used_cars, :photo_content_type, :string # Mime type
    add_column :used_cars, :photo_file_size, :integer # File size in bytes
  end
end
