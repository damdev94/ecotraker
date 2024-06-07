class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :update, :destroy]
  before_action :week_days, only: [:new, :edit, :index]

  def index
    @trips = Trip.all
  end

  def new
    @places = Place.where(user_id: current_user.id)
    @trip = Trip.new
    @trip.days.build
    @vehicles = Vehicle.where(user_id: current_user.id)
  end

  def create
    @places = Place.where(user_id: current_user.id)
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id

    start_place = Place.find(params[:trip][:start_place_id])
    end_place = Place.find(params[:trip][:end_place_id])

    @trip.start_place = start_place
    @trip.end_place = end_place
    @trip.label = "#{start_place.name} to #{end_place.name}"

    if @trip.save
      params[:trip][:schedule].each { |day| Day.create(date: Date.parse(day), trip: @trip) }
      calculate_score(@trip)
      redirect_to trips_path
    else
      @vehicles = Vehicle.where(user_id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @places = Place.where(user_id: current_user.id)
    @vehicles = Vehicle.where(user_id: current_user.id)
    @trip_day_dates = @trip.days.pluck(:date)
  end

  def update
    @places = Place.where(user_id: current_user.id)
    @vehicles = Vehicle.where(user_id: current_user.id)

    start_place = Place.find(params[:trip][:start_place_id])
    end_place = Place.find(params[:trip][:end_place_id])

    @trip.start_place = start_place
    @trip.end_place = end_place

    if @trip.update(trip_params)
      @trip.days.destroy_all
      params[:trip][:schedule].values.each do |day|
        Day.create(date: Date.parse(day), trip: @trip)
      end
      @trip.label = "#{start_place.name} to #{end_place.name}"
      calculate_score(@trip)
      @trip.save
      redirect_to trips_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:label, :start_place_id, :end_place_id, :vehicle_id, schedule: [])
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def week_days
    @week_days = []
    7.times do |i|
      @week_days << [(Date.today + i).strftime("%A"), (Date.today + i)]
    end
  end

  def calculate_score(trip_instance)
    if trip_instance.vehicle.vehicle_type == "car"
      @calculate_score = (trip_instance.vehicle.carbon_kg/100.to_f) * trip_instance.distance * trip_instance.days.count
    elsif trip_instance.vehicle.vehicle_type == "bus"
      @calculate_score = 0.079 * trip_instance.distance * trip_instance.days.count
    elsif trip_instance.vehicle.vehicle_type == "metro"
      @calculate_score = 0.028 * trip_instance.distance * trip_instance.days.count
    elsif trip_instance.vehicle.vehicle_type == "bike" || trip_instance.vehicle.vehicle_type == "walking"

      @calculate_score = 0
    end
    trip_instance.score = @calculate_score
    trip_instance.save
  end

end
