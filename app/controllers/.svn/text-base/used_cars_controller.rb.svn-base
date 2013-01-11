class UsedCarsController < ApplicationController

  before_filter :login_required, :only => [ :edit, :new, :destroy ]
  before_filter :load_used_car, :only => [:edit, :update, :destroy]
  def index
    @used_cars = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :is_activated => true },
      :order => 'created_at DESC'
  end

  def home
    if request.host.split('.').size == 2
      @showroom = Showroom.find :all, :conditions => 'name = "'+
        request.host.split(".")[0]+'"'
      unless @showroom[0].nil?
        redirect_to @showroom[0]
      end
    end
    @car_search = UsedCar.new
    @vehicles = UsedCar.active_cars.all :limit => $NUM_USED_CARS,
      :order => 'created_at DESC'
    @new_cars = NewCar.all :limit => $NUM_USED_CARS, :order => 'created_at DESC'
    @used_cars_count = UsedCar.all.uniq.size
    @new_cars_count = NewCar.all.uniq.size
    @part_categories = PartCategory.all
    @regions = Region.all
  end

  def new
    @used_car = UsedCar.new
    @used_car.pictures.build
  end

  def create
    @used_car = UsedCar.new params[:used_car]
    @used_car.user_id = current_user.id
    @used_car.is_activated = true
    if @used_car.save
      UserMailer.deliver_used_car_ad(@used_car)
      flash[:notice] = 'Used Car Ad is successfully created.'
      redirect_to @used_car
    else
      @used_car.pictures.build
      render :action => "new"
    end
  end

  def update
    if @used_car.update_attributes params[:used_car]
      flash[:notice] = 'Used Car Ad was successfully updated.'
      redirect_to @used_car
    else
      render :action => "edit"
    end
  end

  def show
    @used_car = UsedCar.active_cars.find params[:id]
    @map = params[:map]
    @review = params[:review]
    @reviews = Review.paginate :per_page => 5, :page => params[:page],
      :conditions => 'used_car_id = ' + @used_car.id.to_s,
      :order => 'created_at DESC'
  end

  def destroy
    @used_car.is_activated = false
    @used_car.save!
    redirect_to used_cars_path
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
    unless params[:used_car_price_to].nil?
      to_price = params[:used_car_price_to].gsub(',','')
      @search_query = @search_query + '&&used_car_price_to=' + params[:used_car_price_to]
    end
    unless params[:used_car_price_from].nil?
      from_price = params[:used_car_price_from].gsub(',','')
      @search_query = @search_query + '&&used_car_price_from=' + params[:used_car_price_from]
    end
    if !params[:used_car_make].nil? && !params[:used_car_make].empty?
      make = params[:used_car_make]
    else
      @used_car = UsedCar.new params[:used_car]
      make = @used_car.make
    end
    unless params[:used_car_model].nil?
      model = params[:used_car_model]
      @search_query = @search_query + '&&used_car_model=' + params[:used_car_model]
    end
    unless params[:used_car_city].nil?
      city = params[:used_car_city]
      @search_query = @search_query + '&&used_car_city=' + params[:used_car_city]
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

    conditions = 'is_activated is true'
    if !to_price.empty? && to_price != '--Any--'
      conditions = conditions + ' and asking_price <= ' + to_price
    end
    if !from_price.empty? && from_price != '--Any--'
      conditions = conditions + ' and asking_price >= ' + from_price
    end

    unless make.nil?
      unless make.empty? || make == '--Any--'
        conditions = conditions + ' and make = "' + make + '"'
        @search_query = @search_query + '&&used_car_make=' + make
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

    @used_cars = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => conditions,
      :order => sort_filter

    @filter_by = ''
    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :created_at => (DateTime.now - 1.day)..DateTime.now, :is_activated => true },
      :order => sort_filter
    if search_filter == 'last_24_hours'
      @used_cars = @search_filter_results
      @filter_by = 'Last 24 Hours'
    end
    @last_24_hours = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :created_at => (DateTime.now - 7.day)..DateTime.now, :is_activated => true },
      :order => sort_filter
    if search_filter == 'last_week'
      @used_cars = @search_filter_results
      @filter_by = 'Last Week'
    end
    @last_week = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :created_at => (DateTime.now - 14.day)..DateTime.now, :is_activated => true },
      :order => sort_filter
    if search_filter == 'last_14_days'
      @used_cars = @search_filter_results
      @filter_by = 'Last 14 Days'
    end
    @last_14_days = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :created_at => (DateTime.now - 30.day)..DateTime.now, :is_activated => true },
      :order => sort_filter
    if search_filter == 'last_30_days'
      @used_cars = @search_filter_results
      @filter_by = 'Last 30 days'
    end
    @last_30_days = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :type_of_vehicle => 'van', :is_activated => true },
      :order => sort_filter
    if search_filter == 'van'
      @used_cars = @search_filter_results
      @filter_by = 'Van'
    end
    @van = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :type_of_vehicle => 'truck', :is_activated => true },
      :order => sort_filter
    if search_filter == 'truck'
      @used_cars = @search_filter_results
      @filter_by = 'Truck'
    end
    @truck = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => { :type_of_vehicle => 'sports', :is_activated => true },
      :order => sort_filter
    if search_filter == 'sports'
      @used_cars = @search_filter_results
      @filter_by = 'Sports'
    end
    @sports = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'type_of_vehicle not IN ("sports","truck","van") and is_activated is true',
      :order => sort_filter
    if search_filter == 'car'
      @used_cars = @search_filter_results
      @filter_by = 'Car'
    end
    @car = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'make = "Toyota" and is_activated is true',
      :order => sort_filter
    if search_filter == 'toyota'
      @used_cars = @search_filter_results
      @filter_by = 'Toyota'
    end
    @toyota = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'make = "Honda" and is_activated is true',
      :order => sort_filter
    if search_filter == 'honda'
      @used_cars = @search_filter_results
      @filter_by = 'Honda'
    end
    @honda = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'make = "Suzuki" and is_activated is true',
      :order => sort_filter
    if search_filter == 'suzuki'
      @used_cars = @search_filter_results
      @filter_by = 'Suzuki'
    end
    @suzuki = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'make = "Mitsubishi" and is_activated is true',
      :order => sort_filter
    if search_filter == 'mitsubishi'
      @used_cars = @search_filter_results
      @filter_by = 'Mitsubishi'
    end
    @mitsubishi = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'model = "accord" and is_activated is true',
      :order => sort_filter
    if search_filter == 'accord'
      @used_cars = @search_filter_results
      @filter_by = 'Accord'
    end
    @accord = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'model = "city" and is_activated is true',
      :order => sort_filter
    if search_filter == 'city'
      @used_cars = @search_filter_results
      @filter_by = 'City'
    end
    @city = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'model = "Civic" and is_activated is true',
      :order => sort_filter
    if search_filter == 'civic'
      @used_cars = @search_filter_results
      @filter_by = 'Civic'
    end
    @civic = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'model = "Land-Cruiser" and is_activated is true',
      :order => sort_filter
    if search_filter == 'land_cruiser'
      @used_cars = @search_filter_results
      @filter_by = 'Land Cruiser'
    end
    @land_cruiser = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'asking_price <= 100000 and is_activated is true',
      :order => sort_filter
    if search_filter == 'less_than_1'
      @used_cars = @search_filter_results
      @filter_by = 'Less than 1 lac'
    end
    @less_than_1 = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'asking_price <= 400000 and asking_price > 100000 and is_activated is true',
      :order => sort_filter
    if search_filter == 'between_1_and_4'
      @used_cars = @search_filter_results
      @filter_by = 'Between 1 and 4 lac'
    end
    @between_1_and_4 = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'asking_price <= 600000 and asking_price > 400000 and is_activated is true',
      :order => sort_filter
    if search_filter == 'between_4_and_6'
      @used_cars = @search_filter_results
      @filter_by = 'Between 4 and 6 lac'
    end
    @between_4_and_6 = @search_filter_results.size

    @search_filter_results = UsedCar.paginate :per_page => 5, :page => params[:page],
      :conditions => 'asking_price > 600000 and is_activated is true',
      :order => sort_filter
    if search_filter == 'above_6'
      @used_cars = @search_filter_results
      @filter_by = 'Above 6 lac'
    end
    @above_6 = @search_filter_results.size
  end

  def ask_question
    @questions = ''
    @user_name = 'Unknown'
    @number = 'Not mention'
    @email = 'Not mention'

    unless params[:question].nil?
      @questions = params[:question] + ' '
    end
    unless params[:question1].nil?
      @questions = @questions + ' ' + params[:question1]
    end
    unless params[:question2].nil?
      @questions = @questions + ' ' + params[:question2]
    end
    unless params[:question3].nil?
      @questions = @questions + ' ' + params[:question3]
    end
    unless params[:number].nil?
      @number = params[:number]
    end
    unless params[:email].nil?
      @email = params[:email]
    end
    unless params[:user_name].nil?
      @user_name = params[:user_name]
    end
    @used_car = UsedCar.find params[:used_car_id]
    UserMailer.deliver_ask_question(@questions,@number,@email,@user_name,@used_car)
    redirect_to @used_car
  end

  def contact_us
    @message = params[:message].empty? ? 'No Message Entered' : params[:message]
    @email = params[:user_email].empty? ? 'No Email specified' : params[:user_email]
    @user_name = params[:user_name].empty? ? 'No User Name entered' : params[:user_name]
    UserMailer.deliver_contact_us(@email,@user_name,@message)
    redirect_to root_path
  end

  private
  def load_used_car
    @used_car = current_user.used_cars.active_cars.find params[:id]
  end
end
