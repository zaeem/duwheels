ActionController::Routing::Routes.draw do |map|
  map.resources :makes


  map.resources :regions
  map.resources :reviews
  map.resources :users
  map.resource :session
  map.resources :new_cars, :collection=>{:search=>:any, :price_list => :any,:car_comparison => :any,:car_comparison_ajax => :any}
  map.resources :part_categories
  map.resources :brands
  map.resources :showrooms, :member => {:admin => [:get], :used_car_details => [:get], :new_car_details => [:get], :car_item_details => [:get], :vendor_details => [:get], :vendor_edit => [:get], :vendor_update => [:put], :used_car_edit => [:get], :used_car_update => [:put], :used_car_destroy => [:get] }, :collection => { :used_car_new => [:get], :used_car_create => [:get], :home => [:get] }
  map.resources :vendors, :has_many => :car_items,  :collection => {:category_type=>:any, :report_error =>:any, :advertise => :any}
  map.resource :admins, :member => {:feature_a_merchant => [:get]} ,:only => [:show]
  map.resources :used_cars, :collection => {:search=>:any, :contact_us => [:get]}, :member => {:ask_question => [:get]} do |car|
    car.resources :comments
  end
#  map.search 'used_cars/search/:mk/:md/:pr/:ct', :controller => :used_cars, :action => 'search'
  
  map.activate  '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.signup    '/signup', :controller => 'users', :action => 'new'
  map.login     '/login', :controller => 'sessions', :action => 'new'
  map.logout    '/logout', :controller => 'sessions', :action => 'destroy'
  map.forgot    '/forgot', :controller => 'users', :action => 'forgot'
  map.reset     'reset/:reset_code', :controller => 'users', :action => 'reset'
  map.hotdeals  '/hotdeals', :controller => 'vendors', :action => 'hotdeals'
  map.recommended_merchants  '/recommended_merchants', :controller => 'vendors', :action => 'recommended_merchants'
  map.latest_reviews  '/latest_reviews', :controller => 'vendors', :action => 'all_reviews'
  map.suggest  '/vendor/suggest', :controller => 'vendors', :action => 'suggest'
  map.motor_directory  '/motor_directory', :controller => 'part_categories', :action => 'motor_directory'
  

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "used_cars", :action => 'home'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
