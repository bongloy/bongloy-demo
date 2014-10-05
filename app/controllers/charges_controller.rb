class ChargesController < ApplicationController
  before_action :authenticate_user!

  before_action :checkout_configuration, :only => [:new, :create]

  def new
    @charge = current_user.charges.new
    @charge.amount = @checkout_configuration.amount
    @charge.currency = @checkout_configuration.currency
  end

  def create
    @charge = current_user.charges.new(permitted_params[:charge])
    @charge.token = params[:stripeToken]
    if @charge.save
      redirect_to charges_path
    else
      render :new
    end
  end

  def index
    @grid = ChargesGrid.new(params[:charges_grid]) do |scope|
      current_user.charges.merge(scope).page(params[:page])
    end
  end

  private

  def permitted_params
    params.permit(:charge => [:amount, :currency])
  end

  def checkout_configuration
    @checkout_configuration ||= CheckoutConfiguration.new(:user => current_user)
  end
end
