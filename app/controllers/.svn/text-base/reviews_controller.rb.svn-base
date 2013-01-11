class ReviewsController < ApplicationController

  before_filter :login_required, :only => [ :edit, :new, :destroy ]
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    object = nil
    unless params[:used_car_id].nil?
      object = UsedCar.find params[:used_car_id]
    end
    unless params[:new_car_id].nil?
      object = NewCar.find params[:new_car_id]
    end
    unless params[:vendor_id].nil?
      object = Vendor.find params[:vendor_id]
    end
    @review = object.reviews.build
    @review.user_id = current_user.id
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new params[:review]
    if @review.save
      flash[:notice] = 'Review was successfully created.'
      if @review.vendor.nil? && @review.new_car.nil?
        redirect_to used_car_path(@review.used_car, :review => "true")
      elsif @review.vendor.nil?
        redirect_to new_car_path(@review.new_car, :review => "true")
      else
        redirect_to vendor_path @review.vendor
      end
    else
      render :action => "new"
    end
  end

  def update
    @review = Review.find(params[:id])
    respond_to do |format|
      if @review.update_attributes(params[:review])
        flash[:notice] = 'Review was successfully updated.'
        format.html { redirect_to(@review) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    respond_to do |format|
      format.html { redirect_to(reviews_url) }
    end
  end
end
