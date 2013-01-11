class NewCar < ActiveRecord::Base
  validates_presence_of     :asking_price, :engine_capacity, :transmission,
    :type_of_vehicle, :fuel_type, :milage
  validates_numericality_of :asking_price

  belongs_to :user
  has_many :pictures
  has_many :reviews

  def picture_attributes=(picture_attributes)
    picture_attributes.each do |attributes|
      pictures.build(attributes)
    end
  end

  def list_of_cars_by_make(make)
    car_list = []
    @make = Make.find(:all, :conditions => 'name = "'+make+'"')[0]
    for model in @make.car_models
      obj = NewCar.find_all_by_model(model.name)[0]
      unless obj.nil?
        car_list << obj
      end
    end
    return car_list
  end

end
