class Showroom < ActiveRecord::Base
  belongs_to :vendor
  has_attached_file :photo, :styles => { :medium => "300x225", :thumb => "100x75", :slidermain => "288x193" }
end
