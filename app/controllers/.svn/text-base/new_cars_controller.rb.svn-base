class NewCarsController < ApplicationController

  before_filter :admin_requried, :only => [:new, :edit, :destroy]
  def index
    @new_cars = NewCar.paginate :per_page => 5, :page => params[:page],
      :order => 'created_at DESC'
  end

  def new
    @new_car = NewCar.new
    @new_car.pictures.build
  end

  def create
    @new_car = NewCar.new params[:new_car]
    @new_car.user_id = current_user.id
    if @new_car.save
      UserMailer.deliver_new_car_ad(@new_car)
      flash[:notice] = 'New Car is successfully created.'
      redirect_to @new_car
    else
      render :action => "new"
    end
  end

  def edit
    @new_car = NewCar.find params[:id]
  end

  def update
    @new_car = NewCar.find params[:id]
    if @new_car.update_attributes params[:new_car]
      flash[:notice] = 'New Car was successfully updated.'
      redirect_to @new_car
    else
      render :action => "edit"
    end
  end

  def show
    @new_car = NewCar.find params[:id]
    @review = params[:review]
    @reviews = Review.paginate :per_page => 5, :page => params[:page],
      :conditions => 'new_car_id = ' + @new_car.id.to_s,
      :order => 'created_at DESC'
  end

  def destroy
    @new_car = NewCar.find params[:id]
    @new_car.destroy
    redirect_to new_cars_path
  end

  def search
    make = ''
    model = ''
    from_price = ''
    to_price = ''
    city = ''
    search_filter = ''

    @search_query = '?search=query'
    #?used_car_price_to=100,000&&used_car_price_from=100,000
    unless params[:new_car_price_to].nil?
      to_price = params[:new_car_price_to].gsub(',','')
      @search_query = @search_query + '&&new_car_price_to=' + params[:new_car_price_to]
    end
    unless params[:new_car_price_from].nil?
      from_price = params[:new_car_price_from].gsub(',','')
      @search_query = @search_query + '&&new_car_price_from=' + params[:new_car_price_from]
    end
    if !params[:new_car_make].nil? && !params[:new_car_make].empty?
      make = params[:new_car_make]
    else
      @new_car = NewCar.new params[:new_car]
      make = @new_car.make
    end
    unless params[:new_car_model].nil?
      model = params[:new_car_model]
      @search_query = @search_query + '&&new_car_model=' + params[:new_car_model]
    end
    unless params[:new_car_city].nil?
      city = params[:new_car_city]
      @search_query = @search_query + '&&new_car_city=' + params[:new_car_city]
    end
    unless params[:search_filter].nil?
      search_filter = params[:search_filter]
      @search_query = @search_query + '&&search_filter=' + params[:search_filter]
    end
    sort_filter='asking_price '
    unless params[:sort_filter].nil?
      if params[:sort_filter] == 'ASC'
        sort_filter = sort_filter + 'ASC'
      else
        sort_filter = sort_filter + 'DESC'
      end
    end

    conditions = 'make is not null'
    if !to_price.empty? && to_price != '--Any--'
      conditions = conditions + ' and asking_price <= ' + to_price
    end
    if !from_price.empty? && from_price != '--Any--'
      conditions = conditions + ' and asking_price >= ' + from_price
    end

    unless make.nil?
      unless make.empty? || make == '--Any--'
        conditions = conditions + ' and make = "' + make + '"'
        @search_query = @search_query + '&&new_car_make=' + make
      end
    end

    unless params[:page].nil? || params[:page].empty?
      @search_query = @search_query + '&&page=' + params[:page]
    end

    if !model.empty? && model != '--Any--'
      conditions = conditions + ' and model = "' + model + '"'
    end

    if !city.empty? && city != '--Any--'
      conditions = conditions + ' and registration_city = "' + city + '"'
    end

    @used_cars = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => conditions,
      :order => sort_filter

    @filter_by = ''
    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :created_at => (DateTime.now - 1.day)..DateTime.now},
      :order => sort_filter
    if search_filter == 'last_24_hours'
      @used_cars = @search_filter_results
      @filter_by = 'Last 24 Hours'
    end
    @last_24_hours = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :created_at => (DateTime.now - 7.day)..DateTime.now },
      :order => sort_filter
    if search_filter == 'last_week'
      @used_cars = @search_filter_results
      @filter_by = 'Last Week'
    end
    @last_week = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :created_at => (DateTime.now - 14.day)..DateTime.now },
      :order => sort_filter
    if search_filter == 'last_14_days'
      @used_cars = @search_filter_results
      @filter_by = 'Last 14 Days'
    end
    @last_14_days = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :created_at => (DateTime.now - 30.day)..DateTime.now },
      :order => sort_filter
    if search_filter == 'last_30_days'
      @used_cars = @search_filter_results
      @filter_by = 'Last 30 days'
    end
    @last_30_days = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :type_of_vehicle => 'van' },
      :order => sort_filter
    if search_filter == 'van'
      @used_cars = @search_filter_results
      @filter_by = 'Van'
    end
    @van = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :type_of_vehicle => 'truck' },
      :order => sort_filter
    if search_filter == 'truck'
      @used_cars = @search_filter_results
      @filter_by = 'Truck'
    end
    @truck = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :type_of_vehicle => 'sports' },
      :order => sort_filter
    if search_filter == 'sports'
      @used_cars = @search_filter_results
      @filter_by = 'Sports'
    end
    @sports = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'type_of_vehicle not IN ("sports","truck","van")',
      :order => sort_filter
    if search_filter == 'car'
      @used_cars = @search_filter_results
      @filter_by = 'Car'
    end
    @car = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'make = "Toyota"',
      :order => sort_filter
    if search_filter == 'toyota'
      @used_cars = @search_filter_results
      @filter_by = 'Toyota'
    end
    @toyota = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'make = "Honda"',
      :order => sort_filter
    if search_filter == 'honda'
      @used_cars = @search_filter_results
      @filter_by = 'Honda'
    end
    @honda = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'make = "Suzuki"',
      :order => sort_filter
    if search_filter == 'suzuki'
      @used_cars = @search_filter_results
      @filter_by = 'Suzuki'
    end
    @suzuki = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'make = "Mitsubishi"',
      :order => sort_filter
    if search_filter == 'mitsubishi'
      @used_cars = @search_filter_results
      @filter_by = 'Mitsubishi'
    end
    @mitsubishi = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'model = "accord"',
      :order => sort_filter
    if search_filter == 'accord'
      @used_cars = @search_filter_results
      @filter_by = 'Accord'
    end
    @accord = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'model = "city"',
      :order => sort_filter
    if search_filter == 'city'
      @used_cars = @search_filter_results
      @filter_by = 'City'
    end
    @city = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'model = "Civic"',
      :order => sort_filter
    if search_filter == 'civic'
      @used_cars = @search_filter_results
      @filter_by = 'Civic'
    end
    @civic = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'model = "Land-Cruiser"',
      :order => sort_filter
    if search_filter == 'land_cruiser'
      @used_cars = @search_filter_results
      @filter_by = 'Land Cruiser'
    end
    @land_cruiser = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'asking_price <= 100000',
      :order => sort_filter
    if search_filter == 'less_than_1'
      @used_cars = @search_filter_results
      @filter_by = 'Less than 1 lac'
    end
    @less_than_1 = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'asking_price <= 400000 and asking_price > 100000',
      :order => sort_filter
    if search_filter == 'between_1_and_4'
      @used_cars = @search_filter_results
      @filter_by = 'Between 1 and 4 lac'
    end
    @between_1_and_4 = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'asking_price <= 600000 and asking_price > 400000',
      :order => sort_filter
    if search_filter == 'between_4_and_6'
      @used_cars = @search_filter_results
      @filter_by = 'Between 4 and 6 lac'
    end
    @between_4_and_6 = @search_filter_results.size

    @search_filter_results = NewCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'asking_price > 600000',
      :order => sort_filter
    if search_filter == 'above_6'
      @used_cars = @search_filter_results
      @filter_by = 'Above 6 lac'
    end
    @above_6 = @search_filter_results.size
  end

  def price_list
    @new_car = NewCar.first
    @adam = @new_car.list_of_cars_by_make 'Adam'
    @audi = @new_car.list_of_cars_by_make 'Audi'
    @cadillac = @new_car.list_of_cars_by_make 'Cadillac'
  end

  def car_comparison
    @new_car = NewCar.new
    @new_car1 = NewCar.find :all, :conditions => 'make = "Adam" and model = "Revo"'
    @new_car1 = @new_car1[0]
    @id_name = 'car_detail1'
    @elementId = ''
  end

  def car_comparison_ajax
    car = NewCar.new params[:new_car]
    @id_name = 'car_detail1'
    @elementId = '1'
    unless params[:new_car_model_1].nil?
      model = params[:new_car_model_1]
      @id_name = 'car_detail1'
      @elementId = '1'
    end
    unless params[:new_car_model_2].nil?
      model = params[:new_car_model_2]
      @id_name = 'car_detail2'
      @elementId = '2'
    end
    unless params[:new_car_model_3].nil?
      model = params[:new_car_model_3]
      @id_name = 'car_detail3'
      @elementId = '3'
    end
    
    @new_car1 = NewCar.find :all, :conditions => 'make = "' + car.make + '" and model = "' + model + '"'
    @new_car1 = @new_car1[0]
    respond_to do |format|
      format.html { redirect_to car_comparison_new_cars_path }
      format.js 
    end
  end

end
