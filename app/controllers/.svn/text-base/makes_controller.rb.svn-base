class MakesController < ApplicationController

  before_filter :admin_requried, :except => [:show]
  def index
    @makes = Make.all
  end

  def show
    @make = Make.find params[:id]
  end

  def new
    @make = Make.new
    @make.car_models.build
  end

  def create
    @make = Make.new params[:make]
    if @make.save
      flash[:notice] = 'Make was successfully created.'
      redirect_to @make
    else
      render :action => "new"
    end
  end

  def edit
    @make = Make.find params[:id]
    @make.car_models.build
  end

  def update
    @make = Make.find params[:id]
    if @make.update_attributes params[:make]
      flash[:notice] = 'Make was successfully updated.'
      redirect_to @make
    else
      render :action => "edit"
    end
  end

  def destroy
    @make = Make.find params[:id]
    @make.destroy
    redirect_to makes_path
  end

end
