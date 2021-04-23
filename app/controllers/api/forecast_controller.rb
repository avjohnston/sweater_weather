class Api::V1::ForecastController < ApplicationController
  def index
    @forecast = ForecastFacade.location_forecast(params[:location])
    @serial = ForecastSerializer.new(@forecast)

    render json: @serial
  end
end 