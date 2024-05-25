class PlacesController < ApplicationController

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    if @place.save
      flash.now[:notice] = "Place added successfully."
      redirect_to new_place_path
    else
      flash[:alert] = "There was a problem adding the place."
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:address, :name)
  end

end
