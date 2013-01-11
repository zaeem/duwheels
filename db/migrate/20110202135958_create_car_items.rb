class CreateCarItems < ActiveRecord::Migration
  def self.up
    create_table :car_items do |t|
      t.string :name
      t.string :price
      t.string :condition
      t.boolean :availability
      t.integer :part_category_id
      t.integer :vendor_id
      t.integer :user_id
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :car_items
  end
end
