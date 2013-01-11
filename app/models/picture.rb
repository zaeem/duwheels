class Picture < ActiveRecord::Base
  belongs_to :car_item
  belongs_to :used_car
  belongs_to :new_car
  belongs_to :vendor

  has_attached_file :photo, :styles => { :medium => "300x225", :thumb => "100x75", :slidermain => "288x193" }
end
