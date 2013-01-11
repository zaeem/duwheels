class CarItem < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :condition

  belongs_to :user
  belongs_to :vendor
  belongs_to :part_category
  has_many :pictures

  def picture_attributes=(picture_attributes)
    picture_attributes.each do |attributes|
      pictures.build(attributes)
    end
  end

end
