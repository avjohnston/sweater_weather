class Api::V1::RoadTripsController < ApplicationController
  # frozen_string_literal: true
  def create
    @trip = RoadTripFacade.road_trip_object(road_trip_params[:origin], road_trip_params[:destination])
    @serial = RoadTripSerializer.new(@trip)

    render json: @serial
  end 

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end 
end