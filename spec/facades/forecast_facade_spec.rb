require 'rails_helper'

RSpec.describe ForecastFacade, type: :model do
  describe 'class methods' do 
    it '#location_forecast', :vcr do 
      @forecast = ForecastFacade.location_forecast('denver,co')

      expect(@forecast).to be_a(Forecast)
      expect(@forecast.current_weather).to be_a(Hash)
      expect(@forecast.current_weather.keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(@forecast.daily_weather).to be_an(Array)
      expect(@forecast.daily_weather.size).to eq(5)
      expect(@forecast.daily_weather[0].keys).to eq([:datetime, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      expect(@forecast.hourly_weather).to be_an(Array)
      expect(@forecast.hourly_weather.size).to eq(8)
      expect(@forecast.hourly_weather[0].keys).to eq([:time, :temperature, :conditions, :icon])
    end

    it '#location_forecast for unreadable string shouldnt break', :vcr do 
      @forecast = ForecastFacade.location_forecast('akls84o[)&]')
      
      expect(@forecast).to be_a(Forecast)
      expect(@forecast.current_weather).to be_a(Hash)
      expect(@forecast.current_weather.keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(@forecast.daily_weather).to be_an(Array)
      expect(@forecast.daily_weather.size).to eq(5)
      expect(@forecast.daily_weather[0].keys).to eq([:datetime, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      expect(@forecast.hourly_weather).to be_an(Array)
      expect(@forecast.hourly_weather.size).to eq(8)
      expect(@forecast.hourly_weather[0].keys).to eq([:time, :temperature, :conditions, :icon])
    end
  end 
end