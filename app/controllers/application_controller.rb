class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery(:prepend => true, :with => :exception)

  private

  def setup_charge
    @charge ||= build_charge
  end

  def build_charge
    @charge = Charge.new
    @charge.amount = checkout_configuration.amount_cents
    @charge.currency = checkout_configuration.currency
    @charge.description = checkout_configuration.charge_description
    @charge
  end

  def checkout_configuration
    @checkout_configuration ||= CheckoutConfiguration.find_by_id(session_checkout_configuration) || build_checkout_configuration
    @checkout_configuration.set_defaults
    @checkout_configuration.load_checkout = params[:load_checkout]
    @checkout_configuration
  end

  def session_checkout_configuration
    session[:checkout_configuration_id]
  end

  def store_session_checkout_configuration
    session[:checkout_configuration_id] = checkout_configuration.id
  end

  def build_checkout_configuration
    user_signed_in? ? (current_user.checkout_configuration || current_user.build_checkout_configuration) : CheckoutConfiguration.new
  end
end
