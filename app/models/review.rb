class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :vendor
  belongs_to :used_car
  belongs_to :new_car
end
