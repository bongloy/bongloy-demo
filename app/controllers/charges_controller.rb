class ChargesController < ApplicationController
  before_action :checkout_configuration

  def new
    @charge = Charge.new
    @charge.amount = checkout_configuration.amount
    @charge.currency = checkout_configuration.currency
    @charge.description = checkout_configuration.charge_description
  end

  def create
    @charge = Charge.new(permitted_params[:charge])
    @charge.token = params[:bongloyToken]
    if @charge.save
      bongloy_charge_url = checkout_configuration.bongloy_charges_url
      redirect_to(
        new_charge_path,
        :flash => {
          :success => "Your Charge was successfully created! You can view it on your Dashboard here: #{view_context.link_to(bongloy_charge_url, bongloy_charge_url, :target => '_blank')}<div class='help-block'>Use the following credentials to sign in:<dl class=\"dl-horizontal\"><dt><i class=\"fa fa-envelope\"></i></dt><dd>#{checkout_configuration.bongloy_test_account_email}</dd><dt><i class=\"fa fa-lock\"></i></dt><dd>#{checkout_configuration.bongloy_test_account_password}</dd></dl></div>"
        }
      )
    else
      render :new
    end
  end

  private

  def permitted_params
    params.permit(:charge => [:amount, :currency, :description])
  end

  def checkout_configuration
    @checkout_configuration ||= CheckoutConfiguration.new(
      :user => current_user,
      :load_checkout => params[:load_checkout]
    )
  end
end
