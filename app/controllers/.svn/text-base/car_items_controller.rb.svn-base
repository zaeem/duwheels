class CarItemsController < ApplicationController

  before_filter :vendor_login_required, :only => [ :new ]
  before_filter :vendor_user_required, :only => [ :edit, :destroy ]
  before_filter :list_of_part_categories, :only => [ :new, :create, :edit, :update ]
  before_filter :list_of_brands, :only => [ :new, :create, :edit, :update ]
  def index
    #@car_items = CarItem.find :all
    @vendor = Vendor.find params[:vendor_id]
    @car_items = @vendor.car_items.uniq.paginate :per_page => 5, :page => params[:page]
    @part_categories = PartCategory.all
    @regions = Region.all
  end

  def new
    @car_item = CarItem.new
    @car_item.pictures.build
    vendor_id = params[:vendor_id]
    @car_item.vendor_id = vendor_id
    @vendor = Vendor.find vendor_id
  end

  def create
    @car_item = CarItem.new params[:car_item]
    @car_item.user_id = current_user.id
    if @car_item.save
      @vendor = Vendor.find params[:vendor_id]
      @vendor.car_items << @car_item
      @vendor.part_categories << @car_item.part_category
      @vendor.brands << Brand.find(@car_item.brand_id)
      @vendor.save
      flash[:notice] = 'Car item has been successfully created.'
      redirect_to vendor_car_item_path @vendor, @car_item
    else
      @vendor = Vendor.find params[:vendor_id]
      render  :action => "new"
    end
  end

  def edit
    @car_item  = CarItem.find params[:id]
    vendor_id = params[:vendor_id]
    @car_item.vendor_id = vendor_id
    @vendor = Vendor.find vendor_id
  end

  def update
    @car_item = CarItem.find params[:id]
    if @car_item.update_attributes params[:car_item]
      flash[:notice] = 'Car item has been successfully updated.'
      redirect_to vendor_car_item_path @car_item.vendor, @car_item
    else
      @vendor = Vendor.find params[:vendor_id]
      render :action => "edit"
    end
  end

  def destroy
    @car_item = CarItem.find params[:id]
    @car_item.destroy
    return redirect_to vendor_car_item_path
  end

  def show
    @car_item = CarItem.find params[:id]
    @vendor = Vendor.find params[:vendor_id]
    @part_categories = PartCategory.all
    @regions = Region.all
  end

  def list_of_part_categories
    @part_categories = []
    categories = PartCategory.find :all
    for category in categories
      @part_categories.push [category.name, category.id]
    end
  end

  def list_of_brands
    list_brands = Brand.find :all
    @brands = []
    for brand in list_brands
      @brands.push [brand.name, brand.id]
    end
  end

  private
  def vendor_user_required
    @car_item = CarItem.find params[:id]
    redirect_to login_path unless(current_user && current_user.id == @car_item.vendor.user.id)
  end

  def vendor_login_required
    redirect_to login_path unless(logged_in? && current_user.vendor != nil)
  end

end
