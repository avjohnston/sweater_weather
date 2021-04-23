class Api::V1::ForecastsController < ApplicationController
  def show
    @forecast = ForecastFacade.location_forecast(params[:location])
    @serial = ForecastSerializer.new(@forecast)

    render json: @serial
  end
end 