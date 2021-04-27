require 'rails_helper'

RSpec.describe WeatherService, type: :model do
  describe 'class methods' do 
    it '#get_weather', :vcr do 
      response = WeatherService.get_weather(39.738453, -104.984853)

      expect(response[:current]).to be_a(Hash)
      expect(response[:hourly]).to be_an(Array)
      expect(response[:daily]).to be_an(Array)
    end

    it '#current_weather', :vcr do 
      response = WeatherService.current_weather(39.738453, -104.984853)

      expect(response[:dt]).to be_an(Integer)
      expect(response[:sunrise]).to be_an(Integer)
      expect(response[:sunset]).to be_an(Integer)
      expect(response[:temp]).to be_a(Float)
      expect(response[:feels_like]).to be_a(Float)
      expect(response[:humidity]).to be_an(Integer)
      expect(response[:uvi]).to be_a(Float)
      expect(response[:visibility]).to be_an(Integer)
      expect(response[:weather][0][:description]).to be_a(String)
      expect(response[:weather][0][:icon]).to be_a(String)
    end
    
    it '#hourly_weather', :vcr do 
      response = WeatherService.hourly_weather(39.738453, -104.984853)

      expect(response.size).to eq(8)
      expect(response[0][:dt]).to be_an(Integer)
      expect(response[0][:temp]).to be_a(Float)
      expect(response[0][:weather][0][:description]).to be_a(String)
      expect(response[0][:weather][0][:icon]).to be_a(String)
    end 

    it '#daily_weather', :vcr do 
      response = WeatherService.daily_weather(39.738453, -104.984853)

      expect(response[0][:dt]).to be_an(Integer)
      expect(response[0][:sunrise]).to be_an(Integer)
      expect(response[0][:sunset]).to be_an(Integer)
      expect(response[0][:temp][:min]).to be_a(Float)
      expect(response[0][:temp][:max]).to be_a(Float)
      expect(response[0][:weather][0][:description]).to be_a(String)
      expect(response[0][:weather][0][:icon]).to be_a(String)
    end

    it '#hourly', :vcr do 
      response = WeatherService.hourly(39.738453, -104.984853, 5555)

      expect(response[:temp]).to be_a(Float)
      expect(response[:weather][0].keys).to eq([:id, :main, :description, :icon])
    end
    
    it '#daily', :vcr do
      response = WeatherService.daily(39.738453, -104.984853, 5555555)

      expect(response[:temp][:day]).to be_a(Float)
      expect(response[:weather][0].keys).to eq([:id, :main, :description, :icon])
    end 
  end
end