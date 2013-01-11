class PartCategory < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name
  
  has_and_belongs_to_many :vendors
  has_many :car_items

  def recommended_merchants
    vendors = self.vendors
    rec_mer = []
    for vendor in vendors
      if vendor.vendor_type == "recommended"
        rec_mer.push vendor
      end
    end
    return rec_mer
  end
  
end
