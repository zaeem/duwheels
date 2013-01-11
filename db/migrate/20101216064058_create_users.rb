class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string :login
      t.string :name
      t.string :gender
      t.string :dob
      t.string :city
      t.string :cell_no
      t.string :email
      t.string :crypted_password,          :limit => 40
      t.string :salt,                      :limit => 40
      t.string :reset_code
      t.string :role,                      :default=>"client"
      t.datetime :created_at
      t.datetime :updated_at
      t.string :remember_token
      t.datetime :remember_token_expires_at
      t.string :activation_code,           :limit => 40
      t.datetime :activated_at
    end
  end

  def self.down
    drop_table "users"
  end
end
