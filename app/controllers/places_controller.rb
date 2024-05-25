class PlacesController < ApplicationController

  def index
    @places = Place.all
  end


  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    if @place.save
      redirect_to new_vehicle_path
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:address, :name )
  end

end
