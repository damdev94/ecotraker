class VehiclesController < ApplicationController

  def create
    @trip = Trip.find([params[:id]])
    @day = Day.new(day_params)
    @day.trip_id = @trip.id
  end

  private

  def day_params
    params.require(:day).permit(:date)
  end

end
