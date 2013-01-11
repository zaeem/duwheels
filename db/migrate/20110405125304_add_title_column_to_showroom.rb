class AddTitleColumnToShowroom < ActiveRecord::Migration
  def self.up
    add_column :showrooms, :title, :string
  end

  def self.down
    remove_column :showrooms, :title
  end
end
