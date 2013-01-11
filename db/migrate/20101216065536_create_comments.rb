class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :ad_id, :integer, :null=>false
      t.column :user_id, :integer, :null=>false
      t.column :text, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
