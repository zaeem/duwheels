class CreateAnonymousUsers < ActiveRecord::Migration
  def self.up
    create_table :anonymous_users do |t|
      t.string :name
      t.string :cell_no
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :anonymous_users
  end
end
