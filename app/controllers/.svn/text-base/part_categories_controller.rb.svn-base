class PartCategoriesController < ApplicationController

  before_filter :admin_requried, :except =>[:motor_directory]
  def new
    @part_category = PartCategory.new
  end

  def create
    @part_category = PartCategory.new params[:part_category]
    if @part_category.save
      flash[:notice] = 'Car part category is successfully created.'
      return redirect_to part_categories_path
    else
      return render :action => "new"
    end
  end

  def edit
    @part_category  = PartCategory.find params[:id]
  end

  def update
    @part_category = PartCategory.find params[:id]
    if @part_category.update_attributes params[:part_category]
      flash[:notice] = 'Car part category is successfully updated.'
      return redirect_to part_categories_path
    else
      render :action => "edit"
    end
  end

  def index
    @part_categories = PartCategory.find :all, :order => 'name ASC'
  end

  def motor_directory
    @part_categories = PartCategory.find :all, :order => 'name ASC'
    @regions = Region.all
    @merchants = Vendor.find :all, :conditions => 'vendor_type = "recommended"'
    @hot_deals = CarItem.find :all, :conditions => 'deal_type = true'
    @latest_reviews = Review.find :all, :conditions => 'used_car_id is null', :order => 'created_at DESC'
    @recommended_merchants = []
    for merchant in @merchants
      if merchant.part_category_id.nil?
        @recommended_merchants.push [merchant, 'No special category']
      else
        @recommended_merchants.push [merchant, PartCategory.find(merchant.part_category_id).name]
      end
    end
  end

  def destroy
    @part_category = PartCategory.find params[:id]
    @part_category.destroy
    return redirect_to part_categories_path
  end

  private
  def admin_requried
    return redirect_to new_session_path unless(logged_in? && current_user.admin?)
  end

end
