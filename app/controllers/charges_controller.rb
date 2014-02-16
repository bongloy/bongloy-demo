class ChargesController < ApplicationController
  def new
    @charge = Charge.new
  end

  def create
    @charge = Charge.new(params[:charge])
    redirect_to root_path, :notice => "Successfully Created Charge"
  end
end
