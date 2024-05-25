class VehiclesController < ApplicationController

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user_id = current_user.id
    if @vehicle.save
      redirect_to trips_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @vehicle = Vehicle.where(user_id: current_user.id)
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :year)
  end
end
