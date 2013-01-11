class ShowroomsController < ApplicationController

  before_filter :admin_requried, :only =>[:index, :new, :destroy]
  before_filter :showroom_user_requried, :only =>[:edit, :admin]
  before_filter :used_car_user_required, :only =>[:used_car_destroy, :used_car_edit]
  before_filter :list_of_part_category, :only =>[:vendor_edit, :vendor_update]

  def index
    @showrooms = Showroom.all
  end

  def new
    @showroom = Showroom.new
    @vendors = Vendor.all
    list_vendors = []
    for vendor in @vendors.uniq
      list_vendors.push [vendor.name, vendor.id]
    end
    @vendors = list_vendors
  end

  def create
    @showroom = Showroom.new params[:showroom]
    if @showroom.save
      flash[:notice] = 'Showroom was successfully created.'
      redirect_to @showroom
    else
      render :action => "new"
    end
  end

  def show
    @showroom = Showroom.find params[:id]
  end

  def edit
    @vendors = Vendor.all
    list_vendors = []
    for vendor in @vendors.uniq
      list_vendors.push [vendor.name, vendor.id]
    end
    @vendors = list_vendors
  end

  def update
    @showroom = Showroom.find params[:id]
    if @showroom.update_attributes params[:showroom]
      flash[:notice] = 'Showroom was successfully updated.'
      redirect_to @showroom
    else
      render :action => "edit"
    end
  end

  def destroy
    @showroom = Showroom.find params[:id]
    @showroom.destroy
    render :action => "index"
  end

  def admin
  end

  def home
    @showrooms = Showroom.all
    render :action => 'home', :layout => 'application'
  end

  def used_car_details
    @showroom =  Showroom.find params[:showroom_id]
    @used_car = UsedCar.active_cars.find params[:id]
    @reviews = Review.paginate :per_page => 5, :page => params[:page],
      :conditions => 'used_car_id = ' + @used_car.id.to_s,
      :order => 'created_at DESC'
  end

  def used_car_edit
    @showroom = Showroom.find params[:showroom_id]
  end

  def used_car_update
    @used_car = UsedCar.active_cars.find params[:id]
    @showroom = Showroom.find params[:showroom_id]
    if @used_car.update_attributes params[:used_car]
      flash[:notice] = 'Used Car Ad is successfully updated.'
      redirect_to used_car_details_showroom_path @used_car, :showroom_id => @showroom.id
    else
      render :action => "used_car_edit"
    end
  end

  def used_car_new
    @showroom = Showroom.find params[:showroom_id]
    redirect_to new_session_path unless(logged_in? && current_user.id == @showroom.vendor.user.id)
    @used_car = UsedCar.new
    @used_car.pictures.build
  end

  def used_car_create
    @showroom = Showroom.find params[:showroom_id]
    @used_car = UsedCar.new params[:used_car]
    @used_car.user_id = current_user.id
    @used_car.is_activated = true
    if @used_car.save
      UserMailer.deliver_used_car_ad(@used_car)
      flash[:notice] = 'Used Car Ad was successfully created.'
      redirect_to used_car_details_showroom_path(@used_car, :showroom_id => @showroom.id)
    else
      @used_car.pictures.build
      render :action => "used_car_new"
    end
  end

  def used_car_destroy
    @used_car.is_activated = false
    @used_car.save!
    redirect_to showroom_path params[:showroom_id]
  end

  def new_car_details
    @new_car = NewCar.find params[:id]
    @review = params[:review]
    @reviews = Review.paginate :per_page => 5, :page => params[:page],
      :conditions => 'new_car_id = ' + @new_car.id.to_s,
      :order => 'created_at DESC'
  end

  def vendor_details
    @vendor = Vendor.find params[:id]
    @map = params[:map]
    @review = params[:review]
    @reviews = Review.paginate :per_page => 5, :page => params[:page],
      :conditions => 'vendor_id = ' + @vendor.id.to_s,
      :order => 'created_at DESC'
  end

  def vendor_edit
    @showroom = Showroom.find params[:showroom_id]
    @vendor.pictures.build
  end

  def vendor_update
    @showroom = Showroom.find params[:showroom_id]
    if @vendor.update_attributes params[:vendor]
      flash[:notice] = 'Vendor was successfully updated.'
      redirect_to vendor_details_showroom_path @vendor
    else
      @vendor.pictures.build
      render :action => "vendor_edit"
    end
  end

  def car_item_details
    @car_item = CarItem.find params[:id]
  end

  private
  def showroom_user_requried
    @showroom =  Showroom.find params[:id]
    redirect_to new_session_path unless(logged_in? && current_user.id == @showroom.vendor.user.id)
  end

  def used_car_user_required
    @used_car = UsedCar.active_cars.find params[:id]
    redirect_to new_session_path unless(logged_in? && current_user.id == @used_car.user.id)
  end

  def list_of_part_category
    @vendor = Vendor.find params[:id]
    redirect_to new_session_path unless(logged_in? && current_user.id == @vendor.user.id)
    @part_categories = PartCategory.all
    @list_of_categories=[]
    for category in @part_categories
      @list_of_categories.push [category.name, category.id]
    end
  end

end
