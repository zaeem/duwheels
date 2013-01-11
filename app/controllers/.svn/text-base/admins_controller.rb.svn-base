class AdminsController < ApplicationController

  before_filter :admin_requried
  def show
  end

  def feature_a_merchant
    if request.post?
      for vendor_id in params[:selected_vendors].split('space')
        v = Vendor.find vendor_id.to_i
        v.vendor_type = "recommended"
        v.save
      end
      redirect_to admins_path
    else
      @vendors = Vendor.find :all, :conditions => 'vendor_type is NULL'
    end
  end

end
