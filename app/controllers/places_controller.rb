class PlacesController < ApplicationController


  def index
    @places = Place.all
  end

  def new
    @places = Place.all
    @place = Place.new
    flash[:notice] = session.delete(:place_create_notice)
    flash[:alert] = session.delete(:place_create_alert)
  end

  def create
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    if @place.save
      session[:place_create_notice] = "Place was successfully added."
      redirect_to new_place_path
    else
      session[:place_create_alert] = "There was a problem adding the place."
      render :new
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy

  end


  end

  private

  def place_params
    params.require(:place).permit(:address, :name)
  end
