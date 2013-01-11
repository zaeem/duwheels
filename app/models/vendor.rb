class Vendor < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :phone

  has_many :car_items
  has_one :showroom
  has_many :reviews
  has_many :pictures
  has_and_belongs_to_many :part_categories
  has_and_belongs_to_many :brands

  belongs_to :user

  acts_as_mappable :default_units => :kms, :default_formula => :sphere, :distance_field_name => :distance, :lat_column_name => :latitude, :lng_column_name => :longitude

  def picture_attributes=(picture_attributes)
    picture_attributes.each do |attributes|
      pictures.build(attributes)
    end
  end

  def rating_star
    rating_sum = 0
    total_ratings = 0
    if self.reviews.uniq.empty?
      return 0
    else
      for review in self.reviews.uniq
        total_ratings += 1
        rating_sum = rating_sum + review.rating
      end
    end
    return rating_sum/total_ratings
  end

  def hot_deals
    hot_deals = []
    for item in self.car_items
      if item.deal_type == true
        hot_deals << item
      end
    end
    return hot_deals
  end

  def normal_products
    normal_products = []
    for item in self.car_items
      if item.deal_type != true
        normal_products << item
      end
    end
    return normal_products
  end

  def vendors_by_category_type(cat_type)
    categories = []
    if cat_type == 'accessories'
      categories = PartCategory.find :all, :conditions => 'name in ("Security System","Audio System - In Car Entertainment","Accessories Retail","Car Mats","Keys & Remote","Tracking & Navigation")'
    elsif cat_type == 'performance'
      categories = PartCategory.find :all, :conditions => 'name in ("Tyres & Rims","Power Enhancement","Racing & Motorsports Equipment","CNG Workshop","Handling & Safety")'
    elsif cat_type == 'cosmetic'
      categories = PartCategory.find :all, :conditions => 'name in ("Solar Films & Tinting","Bodykits & Parts","Decals & Stickers")'
    elsif cat_type == 'grooming'
      categories = PartCategory.find :all, :conditions => 'name in ("Car Care Products","Car Grooming - Wash & Polish","Paint Protection","Mobile Car Grooming")'
    elsif cat_type == 'maintainence'
      categories = PartCategory.find :all, :conditions => 'name in ("Repair & Servicing", "Authorised Distributor Workshops", "Air Conditioning", "Car Parts Stockists", "Upholstery - Seats & Tops", "Towing Service", "Spray Painting", "Accident Repairs & Claims", "Windscreen Repair")'
    elsif cat_type == 'car_sales'
      categories = PartCategory.find :all, :conditions => 'name in ("Used Car Dealers","New Car Dealers","Commercial Vehicle Rental","Car Rental","Car Leasing","Chauffeur & Limousine Service")'
    elsif cat_type == 'general_info'
      categories = PartCategory.find :all, :conditions => 'name in ("Motor Insurance Companies", "Finance Companies & Banks", "Evaluation Centres", "Inspection Centres","Scrap Yards","Movers & Storage Services")'
    end
    @vendors = []
    for category in categories
      @vendors.concat category.vendors
    end
    return @vendors
  end

end
