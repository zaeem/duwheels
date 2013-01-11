class RegionsController < ApplicationController

  before_filter :admin_requried
  def index
    @regions = Region.all
  end

  def show
    @region = Region.find(params[:id])
  end

  def new
    @region = Region.new
  end

  def edit
    @region = Region.find(params[:id])
  end

  def create
    @region = Region.new(params[:region])
    if @region.save
      flash[:notice] = 'Region was successfully created.'
      redirect_to(@region)
    else
      render :action => "new"
    end
  end

  def update
    @region = Region.find(params[:id])
    if @region.update_attributes(params[:region])
      flash[:notice] = 'Region was successfully updated.'
      redirect_to @region
    else
      render :action => "edit"
    end
  end

  def destroy
    @region = Region.find(params[:id])
    @region.destroy
    redirect_to regions_path
  end

  private
  def admin_requried
    return redirect_to new_session_path unless(logged_in? && current_user.admin?)
  end
  
end
