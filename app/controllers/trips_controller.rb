class TripsController < ApplicationController
  before_action :set_trip, only: [:edit, :update, :destroy]
  before_action :week_days, only: [:new, :edit, :index]

  def index
    @trips = Trip.where(user_id: current_user.id).order(updated_at: :desc)
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
      if params[:trip][:schedule].present? && params[:trip][:schedule].values.any?
        params[:trip][:schedule].values.each { |day| Day.create(date: Date.parse(day), trip: @trip) }
        calculate_score(@trip)
        redirect_to trips_path
      else
        flash[:error] = "Please select at least one day."
        redirect_to new_trip_path
      end
    else
      @vehicles = Vehicle.where(user_id: current_user.id)
      flash.now[:error] = "Please select at least one day." # Définir le message d'erreur pour la nouvelle tentative
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
    params.require(:trip).permit(:label, :start_place_id, :end_place_id, :vehicle_id, :round, schedule: [])
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def week_days
    @week_days = []
    date  = Date.parse("Monday")
    delta = date > Date.today ? 0 : 7
    date += delta
    7.times do |i|
      @week_days << [(date + i).strftime("%A"), (date + i)]
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
