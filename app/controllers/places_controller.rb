class PlacesController < ApplicationController


  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    if @place.save
      redirect_to vehicle_new_path
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:address, :name )
  end

end
