class CreateAbstractUsers < ActiveRecord::Migration
  def self.up
    create_table :abstract_users do |t|
      t.integer :du_user_id
      t.string :du_user_type
      t.timestamps
    end
  end

  def self.down
    drop_table :abstract_users
  end
end
