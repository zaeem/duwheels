class UsedCar < ActiveRecord::Base

  validates_presence_of     :car_plate_no, :asking_price, :registration_date,
    :engine_capacity, :transmission, :type_of_vehicle, :fuel_type, :milage,
    :no_of_owners, :registration_city
  validates_numericality_of :asking_price
#  validates_inclusion_of    :type_of_vehicle,
#    :in => %w(Hatchback Hybrid MPV Sedan Luxury Sedan SUV Sports Stationwagon Truck Van Others)

  has_one :ad, :as => :du_ad
  has_one :car_make
  has_one :car_model
  has_many :comments
  has_many :pictures
  has_many :reviews
  belongs_to :abstract_user
  belongs_to :user

  named_scope :current_user_cars,  lambda{|current_user_id| {:conditions => {:user_id => current_user_id}}}
  named_scope :active_cars,  :conditions =>{:is_activated => true}

  acts_as_mappable :default_units => :kms, :default_formula => :sphere, :distance_field_name => :distance, :lat_column_name => :latitude, :lng_column_name => :longitude

  def picture_attributes=(picture_attributes)
    picture_attributes.each do |attributes|
      pictures.build(attributes)
    end
  end

end
