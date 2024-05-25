class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  def index
    @trips = Trip.all
  end

  def show

  end

  def new
    @places = Place.where(user_id: current_user.id).all
    @day = Day.new
    @trip = Trip.new
    @trip.days.build
    @vehicles = Vehicle.where(user_id: current_user.id)

    @week_days = []
    i = 0
    7.times do
      @week_days << [(Date.today + i).strftime("%A"), Date.today + i]
      i += 1
    end
  end

  def create
    @places = Place.where(user_id: current_user.id).all
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id

    start_place = Place.find(params[:trip][:start_place_id])
    end_place = Place.find(params[:trip][:end_place_id])

    @trip.start_place = start_place
    @trip.end_place = end_place
    @trip.label = "#{start_place.name} to #{end_place.name}"

    if @trip.save
      params[:trip][:schedule].each { |day| Day.create(date: Date.parse(day), trip: @trip) }
      redirect_to trips_path
    else
      @vehicles = Vehicle.where(user_id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @places = Place.where(user_id: current_user.id).all
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
    params.require(:trip).permit(:label, :start, :end, :schedule, :vehicle_id)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
