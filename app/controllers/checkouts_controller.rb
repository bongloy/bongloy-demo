class CheckoutsController < ApplicationController
  def show
    setup_charge
  end

  private

  def checkout_configuration
    super
    @checkout_configuration.attributes = permitted_params
    @checkout_configuration
  end

  def permitted_params
    params.permit(:amount_cents, :name, :description, :label)
  end
end
