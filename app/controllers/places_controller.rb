class PlacesController < ApplicationController


  def index
    @places = Place.all

  end

  def new
    @places = Place.where(user: current_user)
    @place = Place.new
  end

  def create
    @places = Place.all
    @place = Place.new(place_params)
    @place.user_id = current_user.id
    if @place.save
      redirect_to new_place_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to new_place_path


  end


  end

  private

  def place_params
    params.require(:place).permit(:address, :name)
  end
