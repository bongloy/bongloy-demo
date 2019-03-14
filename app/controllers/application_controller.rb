class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery(:prepend => true, :with => :exception)

  helper_method :checkout_configuration
  
  def checkout_configuration
    @checkout_configuration ||= CheckoutConfiguration.new
  end
end
