require "open-uri"
require "json"
require "rest-client"

class VehiclesController < ApplicationController

  def new
    @vehicle = Vehicle.new
  end

  def create
    params[:vehicle_type].each do |vehicle_type|
      if vehicle_type == "car"
        @vehicle = Vehicle.new(vehicle_params)

        url_brand = "https://www.carboninterface.com/api/v1/vehicle_makes"
        token = 'dOD3GnxZFQjx6nLuMcN9w'

        URI.open(url_brand, 'Authorization' => "Bearer #{token}") do |response|
          response_serialized = response.read
          response_json = JSON.parse(response_serialized)
          brand_element = response_json.find do |brand|
            brand["data"]["attributes"]["name"] == @vehicle.brand
          end
          if brand_element
            @brand_id = brand_element["data"]["id"]
          end
        end

        url_model = "https://www.carboninterface.com/api/v1/vehicle_makes/#{@brand_id}/vehicle_models"

        URI.open(url_model, 'Authorization' => "Bearer #{token}") do |response|
          response_serialized = response.read
          response_json = JSON.parse(response_serialized)
          model_element = response_json.find do |model|
            model["data"]["attributes"]["name"] == @vehicle.model && model["data"]["attributes"]["year"] == @vehicle.year.to_i
          end
          if model_element
            @model_id = model_element["data"]["id"]
          end
        end

        url_consumption = "https://www.carboninterface.com/api/v1/estimates"

        data = {
          "type": "vehicle",
          "distance_unit": "km",
          "distance_value": 100,
          "vehicle_model_id": @model_id
        }

        RestClient.post(url_consumption, data.to_json, { content_type: :json, accept: :json, authorization: "Bearer #{token}" }) do |response|
          response_json = JSON.parse(response)
          @carbon_kg = response_json["data"]["attributes"]["carbon_kg"]
        end

        @vehicle.api_id = @model_id
        @vehicle.carbon_kg = @carbon_kg

      else
        @vehicle = Vehicle.new
      end
      @vehicle.vehicle_type = vehicle_type
      @vehicle.user_id = current_user.id

      @vehicle.save unless render :new, status: :unprocessable_entity
    end
    redirect_to trips_path

  end

  def edit
    @vehicle = Vehicle.where(user_id: current_user.id)
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:brand, :model, :year)
  end
end
