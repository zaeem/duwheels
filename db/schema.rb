# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110405125304) do

  create_table "abstract_users", :force => true do |t|
    t.integer  "du_user_id"
    t.string   "du_user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "anonymous_users", :force => true do |t|
    t.string   "name"
    t.string   "cell_no"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands_vendors", :id => false, :force => true do |t|
    t.integer "brand_id"
    t.integer "vendor_id"
  end
  
  
  create_table "new_cars", :force => true do |t|
    t.string   "make"
    t.string   "model"
    t.integer  "asking_price"
    t.string   "engine_capacity"
    t.string   "transmission"
    t.string   "type_of_vehicle"
    t.string   "fuel_type"
    t.string   "milage"
    t.string   "feature"
    t.text     "accessories"
    t.text     "description"
    t.integer  "user_id"
    t.string   "model_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end


  create_table "car_items", :force => true do |t|
    t.string   "name"
    t.string   "price"
    t.string   "condition"
    t.boolean  "availability"
    t.integer  "part_category_id"
    t.integer  "vendor_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brand_id"
    t.boolean  "deal_type"
  end

  create_table "car_models", :force => true do |t|
    t.string   "name"
    t.integer  "make_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "ad_id",      :null => false
    t.integer  "user_id",    :null => false
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "makes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "part_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "part_categories_vendors", :id => false, :force => true do |t|
    t.integer "part_category_id"
    t.integer "vendor_id"
  end

  create_table "pictures", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.integer  "used_car_id"
    t.integer  "car_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vendor_id"
    t.integer  "new_car_id"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.string   "title"
    t.integer  "rating"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "used_car_id"
    t.integer  "vendor_id"
    t.integer  "new_car_id"
  end

  create_table "showrooms", :force => true do |t|
    t.string   "name"
    t.integer  "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "title"
  end

  create_table "used_cars", :force => true do |t|
    t.string   "car_plate_no"
    t.string   "make"
    t.string   "model"
    t.integer  "abstract_user_id"
    t.integer  "asking_price"
    t.datetime "registration_date"
    t.string   "engine_capacity"
    t.string   "transmission"
    t.string   "type_of_vehicle"
    t.string   "fuel_type"
    t.string   "milage"
    t.string   "no_of_owners"
    t.string   "feature"
    t.text     "accessories"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "is_activated"
    t.string   "registration_city"
    t.string   "model_year"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "gender"
    t.string   "dob"
    t.string   "city"
    t.string   "cell_no"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "reset_code"
    t.string   "role",                                    :default => "client"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "vendor_type"
    t.integer  "user_id"
  end

end
