class Tax::VehiclesController < ApplicationController
  before_action :set_tax_vehicle, only: [:show, :pay, :update, :destroy]

  def show
  end

  def new
    @tax_vehicle = Tax::Vehicle.prefill
  end

  def pay
  end

  # POST /tax/vehicles
  def create
    @tax_vehicle = Tax::Vehicle.new(tax_vehicle_params)

    if @tax_vehicle.save
      redirect_to [:pay, @tax_vehicle]
    else
      render :new
    end
  end

  def update
    if @tax_vehicle.charge(charge_params)
      redirect_to @tax_vehicle
    else
      render :pay
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_vehicle
      @tax_vehicle = Tax::Vehicle.find(params[:id])
    end

    def charge_params
      params.require(:tax_vehicle).permit(:token)
    end

    # Only allow a trusted parameter "white list" through.
    def tax_vehicle_params
      params.require(:tax_vehicle).permit(
        :plate_number,
        :brand,
        :vehicle_type, :color, :engine_number, :year, :power, :name, :en_name, :gender, :birth_date, :id_number, :home, :street, :vilage, :commune, :district, :city, :email, :phone_number)
    end
end
