class ChargesController < ApplicationController
  helper_method :charge

  def new; end

  def create
    @charge = Charge.new(permitted_params[:new_charge])

    if @charge.save
      redirect_to(
        new_charge_path,
        notice: "Your Charge was successfully created!"
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
    params.permit(new_charge: %i[token description])
  end
end
