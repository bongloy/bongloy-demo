class ChargesController < ApplicationController
  before_action :authenticate_user!

  before_action :configure_checkout, :only => :new

  private

  def configure_checkout
    @checkout_configuration = CheckoutConfiguration.new(:user => current_user)
  end
end
