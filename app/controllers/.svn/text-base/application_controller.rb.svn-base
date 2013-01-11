# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :card_number, :card_verification

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def admin_requried
    redirect_to new_session_path unless(logged_in? && current_user.admin?)
  end

end
