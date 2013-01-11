class Make < ActiveRecord::Base

  has_many :car_models

  def car_model_attributes=(car_model_attributes)
    car_model_attributes.each do |attributes|
      car_models.build(attributes)
    end
  end

end
