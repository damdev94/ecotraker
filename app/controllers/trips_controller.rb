class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.all
  end

  def show

  end

  def new
    @day = Day.new
    @trip = Trip.new
    @trip.days.build
    @vehicles = Vehicle.where(user_id: current_user.id)
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    if @trip.save
      redirect_to trips_path
    else
      @vehicles = Vehicle.where(user_id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @vehicles = Vehicle.where(user_id: current_user.id)
  end

  def update
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      @vehicles = Vehicle.where(user_id: current_user.id)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:label, :start, :end, :vehicle_id, days_attributes: [:id, :date, :_destroy])
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
