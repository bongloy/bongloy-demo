class Tax::VehiclesController < ApplicationController
  before_action :set_tax_vehicle, only: [:show, :edit, :update, :destroy]

  # GET /tax/vehicles
  def index
    @tax_vehicles = Tax::Vehicle.all
  end

  # GET /tax/vehicles/1
  def show
  end

  # GET /tax/vehicles/new
  def new
    @tax_vehicle = Tax::Vehicle.new
  end

  # GET /tax/vehicles/1/edit
  def edit
  end

  # POST /tax/vehicles
  def create
    @tax_vehicle = Tax::Vehicle.new(tax_vehicle_params)

    if @tax_vehicle.save
      redirect_to @tax_vehicle, notice: 'Vehicle was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tax/vehicles/1
  def update
    if @tax_vehicle.update(tax_vehicle_params)
      redirect_to @tax_vehicle, notice: 'Vehicle was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tax/vehicles/1
  def destroy
    @tax_vehicle.destroy
    redirect_to tax_vehicles_url, notice: 'Vehicle was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax_vehicle
      @tax_vehicle = Tax::Vehicle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tax_vehicle_params
      params.require(:tax_vehicle).permit(:plate_number, :brand, :type, :color, :engine_number, :year, :power, :name, :en_name, :gender, :birth_date, :id_number, :home, :street, :vilage, :commune, :district, :city, :email, :phone_number, :reference_number)
    end
end
