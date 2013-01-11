class VendorsController < ApplicationController

  before_filter :login_required, :only => [ :edit, :new, :destroy ]
  before_filter :vendor_user_required, :only => [ :edit, :update, :destroy ]
  before_filter :list_of_categories , :only => [:new, :create, :edit, :update]
  def new
    @vendor = Vendor.new
    @vendor.pictures.build
  end

  def create
    @vendor = Vendor.new params[:vendor]
    @vendor.user_id = current_user.id
    if @vendor.save
      UserMailer.deliver_vendor_creation @vendor
      flash[:notice] = 'Vendor was successfully created.'
      redirect_to @vendor
    else
      @vendor.pictures.build
      render :action => "new"
    end
  end

  def edit
    @vendor  = Vendor.find params[:id]
  end


  def update
    @vendor = Vendor.find params[:id]
    if @vendor.update_attributes params[:vendor]
      flash[:notice] = 'Vendor was successfully updated.'
      redirect_to @vendor
    else
      render :action => "edit"
    end
  end

  def destroy
    @vendor = Vendor.find params[:id]
    @vendor.destroy
    redirect_to vendors_path
  end

  def show
    @vendor = Vendor.find params[:id]
    @part_categories = PartCategory.find :all, :order => 'name ASC'
    @map = params[:map]
    @review = params[:review]
    @reviews = Review.paginate :per_page => 5, :page => params[:page],
      :conditions => 'vendor_id = ' + @vendor.id.to_s,
      :order => 'created_at DESC'
    @regions = Region.all
  end

  def search
    render :action => "index"
  end

  def recommended_merchants
    @part_categories = PartCategory.all
  end

  def all_reviews
    @reviews = []
    vendors=Vendor.all
    for vendor in vendors
      @reviews.concat vendor.reviews
    end
    @reviews = @reviews.paginate :per_page => 5, :page => params[:page],
      :order => 'created_at DESC'
  end

  def report_error
    if request.post?
      name = params[:name]
      contact_no = params[:phone]
      email = params[:email]
      error = params[:error]
      UserMailer.deliver_report_error(name,contact_no,email,error)
      redirect_to motor_directory_path
    end
  end

  def advertise
    if request.post?
      name = params[:name]
      phone = params[:phone]
      email = params[:email]
      remarks = params[:remarks]
      organisation = params[:organisation]
      UserMailer.deliver_advertise(name,phone,email,remarks,organisation)
      redirect_to motor_directory_path
    end
  end

  def suggest
    if request.post?
      @merchant_name = ''
      @category = ''
      @phone = ''
      @comments = 'No comments'
      unless params[:merchant_name].nil?
        @merchant_name = params[:merchant_name]
      end
      if params[:category] != 0
        @category = params[:category]
      end
      unless params[:phone].nil?
        @phone = params[:phone]
      end
      unless params[:comments].nil?
        @comments = params[:comments]
      end
      UserMailer.deliver_suggest_merchant(@merchant_name,@category,@phone,@comments)
      redirect_to motor_directory_path
    end
  end

  def category_type
    @cat_type = params[:type]
    @vendorr = Vendor.first
    @vendors = @vendorr.vendors_by_category_type @cat_type

    @category_title = 'Any Category'
    @part_categories = PartCategory.find :all, :order => 'name ASC'
    @regions = Region.all
    @recommended_merchants = []
    @normal_merchants = []
    for vendor in @vendors.uniq
      if vendor.vendor_type == "recommended"
        @recommended_merchants << vendor
      else
        @normal_merchants << vendor
      end
    end
    render :action => 'index'
  end

  def hotdeals
    @car_accessories = PartCategory.find :all, :conditions => 'name in ("Security System","Audio System - In Car Entertainment","Accessories Retail","Car Mats","Keys & Remote","Tracking & Navigation")'
    @car_performances = PartCategory.find :all, :conditions => 'name in ("Tyres & Rims","Power Enhancement","Racing & Motorsports Equipment","CNG Workshop","Handling & Safety")'
    @cosmetic_enhancements = PartCategory.find :all, :conditions => 'name in ("Solar Films & Tinting","Bodykits & Parts","Decals & Stickers")'
    @tyres_and_rims = PartCategory.find :all, :conditions => 'name in ("Tyres & Rims")'
    @car_entertainments = PartCategory.find :all, :conditions => 'name in ("Audio System - In Car Entertainment")'
    @car_groomings = PartCategory.find :all, :conditions => 'name in ("Car Care Products","Car Grooming - Wash & Polish","Paint Protection","Mobile Car Grooming")'
    @repair_maintenances = PartCategory.find :all, :conditions => 'name in ("Repair & Servicing","Authorised Distributor Workshops","Air Conditioning","Car Parts Stockists","Upholstery - Seats & Tops","Towing Service","Spray Painting","Accident Repairs & Claims","Windscreen Repair")'
    @car_relateds = PartCategory.find :all, :conditions => 'name in ("Security System","Audio System - In Car Entertainment","Accessories Retail","Car Mats","Keys & Remote","Tracking & Navigation")'
    @car_rentals = PartCategory.find :all, :conditions => 'name in ("Used Car Dealers","New Car Dealers","Commercial Vehicle Rental","Car Rental","Car Leasing","Chauffeur & Limousine Service")'

    @car_items_in_car_accessories = []
    for car_accessory in @car_accessories
      @car_items_in_car_accessories.concat car_accessory.car_items
    end

    @car_items_in_car_performances = []
    for car_performance in @car_performances
      @car_items_in_car_performances.concat car_performance.car_items
    end

    @car_items_in_cosmetic_enhancements = []
    for cosmetic_enhancement in @cosmetic_enhancements
      @car_items_in_cosmetic_enhancements.concat cosmetic_enhancement.car_items
    end

    @car_items_in_tyres_and_rims = @tyres_and_rims[0].car_items
    @car_items_in_car_entertainments = @car_entertainments[0].car_items

    @car_items_in_car_groomings = []
    for car_grooming in @car_groomings
      @car_items_in_car_groomings.concat car_grooming.car_items
    end

    @car_items_in_repair_maintenances = []
    for repair_maintenance in @repair_maintenances
      @car_items_in_repair_maintenances.concat repair_maintenance.car_items
    end

    @car_items_in_car_relateds = []
    for car_related in @car_relateds
      @car_items_in_car_relateds.concat car_related.car_items
    end

    @car_items_in_car_rentals = []
    for car_rental in @car_rentals
      @car_items_in_car_rentals.concat car_rental.car_items
    end
    render :action => "hotdeals"
  end

  def index
    keyword = ''
    category_id = ''
    distance = ''
    area = ''

    keyword = params[:keyword]
    category_id = params[:category]
    distance = params[:select_distance]
    area = params[:select_area]

    @vendors_keyword = []
    @vendors_category = []
    @vendors_area = []

    @keyword_category = ''

    unless keyword.nil?
      if keyword != 'Company name, product or brand'
        @vendors_keyword = Vendor.find :all, :conditions => ['name like ?', "%#{keyword}%"]
        if @vendors_keyword.empty?
          brand = Brand.find :all, :conditions => ['name like ?', "%#{keyword}%"]
          if brand.empty?
            part_category = PartCategory.find :all, :conditions => ['name like ?', "%#{keyword}%"]
            unless part_category.empty?
              @vendors_keyword = []
              for pc in part_category
                @vendors_keyword.concat pc.vendors
              end
            end
          else
            for b in brand
              @vendors_keyword.concat b.vendors
            end
          end
        end
      end
    end

    part_category = nil
    unless category_id.nil?
      if category_id != 'Any Category'
        part_category = PartCategory.find category_id
        @vendors_category = part_category.vendors
      end
    end

    unless distance.nil?
      unless area.nil?
        if distance != 'Any Distance' && area != 'Any Area'
          @vendors_area = Vendor.find(:all, :origin =>[area.partition(",")[0].to_f,area.partition(",")[2].to_f], :within=>distance.to_i)
        elsif distance == 'Any Distance' && area != 'Any Area'
          @vendors_area = Vendor.find(:all, :origin =>[area.partition(",")[0].to_f,area.partition(",")[2].to_f])
        end
      end
    end

    # we should 'and' the following lists
    # like listA = [1,2,3] and listB = [2,3,4]
    # their 'and' shall be [2,3]
    @vendors = []
    unless @vendors_category.empty?
      @vendors = @vendors_category
    end
    unless @vendors_keyword.empty?
      if @vendors.empty?
        @vendors = @vendors_keyword
      else
        @vendors = @vendors_keyword & @vendors
      end
    end
    unless @vendors_area.empty?
      if @vendors.empty?
        @vendors = @vendors_area
      else
        @vendors = @vendors_area & @vendors
      end
    end
    if keyword == 'Company name, product or brand' && category_id == 'Any Category' && distance == 'Any Distance' && area == 'Any Area'
      @vendors = Vendor.all
    end
    @category_title = ''
    if category_id.nil? || category_id == 'Any Category'
      @category_title = 'Any Category'
    else
      @category_title = part_category.name
    end
    unless @keyword_category.empty?
      @category_title = @keyword_category
    end

    @part_categories = PartCategory.find :all, :order => 'name ASC'
    @regions = Region.all
    @vendors = @vendors.uniq.paginate :per_page => 5, :page => params[:page],
      :order => 'vendor_type ASC'
  end

  private
  def vendor_user_required
    @vendor = Vendor.find params[:id]
    redirect_to login_path unless(current_user && current_user.id == @vendor.user.id)
  end

  def list_of_categories
    @part_categories = PartCategory.all
    @list_of_categories=[]
    for category in @part_categories
      @list_of_categories.push [category.name,category.id]
    end
  end

end
