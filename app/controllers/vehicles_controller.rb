class VehiclesController < ApplicationController

  def new
    @vehicle = Vehicle.new
  end

  def create
    params[:vehicle_type].each do |vehicle_type|
      if vehicle_type == "car"
        @vehicle = Vehicle.new(vehicle_params)
      else
        @vehicle = Vehicle.new
      end
      @vehicle.vehicle_type = vehicle_type
      @vehicle.user_id = current_user.id

      unless @vehicle.save
        render :new, status: :unprocessable_entity
      end
    end
    redirect_to trips_path

  end

  def edit
    @vehicle = Vehicle.where(user_id: current_user.id)
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :year)
  end
end
