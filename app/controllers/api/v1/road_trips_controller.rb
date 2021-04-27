class Api::V1::RoadTripsController < ApplicationController
  def create
    if !params_good?
      render json: { error: 'invalid api key' }, status: 401
    elsif params_good? && !valid_trip?
      @trip = RoadTripFacade.sad_road_trip_object(trip_params[:origin], trip_params[:destination])
      @serial = RoadTripSerializer.new(@trip)
  
      render json: @serial, status: 201
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

  def params_good?
    return false if User.where(api_key: trip_params[:api_key]).empty?
    true
  end

  def valid_trip?
    return true if !RoadTripService.get_travel_info(trip_params[:origin], trip_params[:destination]).empty?
    false
  end 
end