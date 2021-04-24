class Api::V1::ForecastsController < ApplicationController
  def show
    if params[:location]
    @forecast = ForecastFacade.location_forecast(params[:location])
    @serial = ForecastSerializer.new(@forecast)

    render json: @serial
    else 
      invalid_params
    end
  end
end 