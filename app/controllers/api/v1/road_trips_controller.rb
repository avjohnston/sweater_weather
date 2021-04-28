class Api::V1::RoadTripsController < ApplicationController
  def create
    if invalid_locations?
      render json: { error: 'both origin and destination must be present' }, status: 400
    elsif bad_api?
      render json: { error: 'invalid api key' }, status: 401
    else
      @trip = RoadTripFacade.road_trip_object(trip_params[:origin], trip_params[:destination])
      @serial = RoadTripSerializer.new(@trip)
      
      render json: @serial, status: 201
    end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end 
end