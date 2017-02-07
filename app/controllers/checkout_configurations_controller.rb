class CheckoutConfigurationsController < ApplicationController
  def create
    if checkout_configuration.update_attributes(permitted_params[:checkout_configuration])
      store_session_checkout_configuration
      redirect_to(
        root_path,
        :flash => {
          :success => "Checkout Configuration Updated!"
        }
      )
    else
      setup_charge
      render("charges/new")
    end
  end

  private

  def permitted_params
    params.permit(
      :checkout_configuration => [
        :amount,
        :name,
        :description,
        :product_description,
        :label
      ]
    )
  end
end
