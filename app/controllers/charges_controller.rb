class ChargesController < ApplicationController
  helper_method :checkout_configuration, :charge

  def new; end

  def create
    @charge = Charge.new(permitted_params[:new_charge])
    if @charge.save
      redirect_to(
        new_charge_path,
        flash: {
          success: "Your Charge was successfully created! You can view it on your Dashboard #{view_context.link_to('here', 'https://www.bongloy.com/dashboard/charges', target: '_blank')}<div class='help-block'>Use the following credentials to sign in:<dl class=\"dl-horizontal\"><dt>Email</dt><dd>#{checkout_configuration.bongloy_test_account_email}</dd><dt>Password</dt><dd>#{checkout_configuration.bongloy_test_account_password}</dd></dl></div>"
        }
      )
    else
      render :new
    end
  end

  private

  def charge
    @charge ||= Charge.new
  end

  def permitted_params
    params.permit(new_charge: %i[token amount currency description])
  end

  def checkout_configuration
    @checkout_configuration ||= CheckoutConfiguration.new
  end
end
