class BrandsController < ApplicationController

  before_filter :admin_requried
  def index
    @brands = Brand.find :all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new params[:brand]
    if @brand.save
      flash[:notice] = 'Brand is successfully created.'
      redirect_to brands_path
    else
      return render :action => "new"
    end
  end

  def destroy
    @brand = Brand.find params[:id]
    @brand.destroy
    redirect_to brands_path
  end

end
