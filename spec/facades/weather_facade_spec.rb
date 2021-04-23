require 'rails_helper'

RSpec.describe WeatherFacade, type: :model do
  before :each do
    @lat = 39.738453
    @lon = -104.984853
  end

  describe 'class methods' do 
    it '#current_attributes', :vcr do 
      @current = WeatherFacade.current_attribute(@lat, @lon)
      result = [
                  :datetime, 
                  :sunrise, 
                  :sunset, 
                  :temperature, 
                  :feels_like, 
                  :humidity, 
                  :uvi, 
                  :visibility, 
                  :conditions, 
                  :icon
                ]

      expect(@current).to be_a(Hash)
      expect(@current.keys).to eq(result)
    end 

    it '#hourly_attributes', :vcr do 
      @hourly = WeatherFacade.hourly_attribute(@lat, @lon)
      
      expect(@hourly.size).to eq(8)
      expect(@hourly[0].keys).to eq([:time, :temperature, :conditions, :icon])
    end
    
    it '#daily_attributes', :vcr do 
      @daily = WeatherFacade.daily_attribute(@lat, @lon)
      result = [
                  :datetime, 
                  :sunrise, 
                  :sunset, 
                  :max_temp,
                  :min_temp,
                  :conditions, 
                  :icon
                ]

      expect(@daily.size).to eq(5)
      expect(@daily[0].keys).to eq(result)
    end 

    it '#temp_to_f' do 
      expect(WeatherFacade.temp_to_f(299)).to eq(78.53)
      expect(WeatherFacade.temp_to_f(321)).to eq(118.13)
    end 

    it '#weather_objects', :vcr do 
      @forecast = WeatherFacade.weather_objects(@lat, @lon)

      expect(@forecast).to be_a(Forecast)
      expect(@forecast.current_weather).to be_a(Hash)
      expect(@forecast.daily_weather).to be_an(Array)
      expect(@forecast.daily_weather[0]).to be_a(Hash)
      expect(@forecast.hourly_weather).to be_an(Array)
      expect(@forecast.hourly_weather[0]).to be_a(Hash)
      expect(@forecast.current_weather).to be_a(Hash)
    end 
  end 
end