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

      expect(response[:dt]).to eq(1619203041)
      expect(response[:sunrise]).to eq(1619179818)
      expect(response[:sunset]).to eq(1619228742)
      expect(response[:temp]).to eq(286.53)
      expect(response[:feels_like]).to eq(284.52)
      expect(response[:humidity]).to eq(23)
      expect(response[:uvi]).to eq(6.02)
      expect(response[:visibility]).to eq(10000)
      expect(response[:weather][0][:description]).to eq('few clouds')
      expect(response[:weather][0][:icon]).to eq('02d')
    end
    
    it '#hourly_weather', :vcr do 
      response = WeatherService.hourly_weather(39.738453, -104.984853)

      expect(response.size).to eq(8)
      expect(response[0][:dt]).to eq(1619200800)
      expect(response[0][:temp]).to eq(286.24)
      expect(response[0][:weather][0][:description]).to eq('scattered clouds')
      expect(response[0][:weather][0][:icon]).to eq('03d')
    end 

    it '#daily_weather', :vcr do 
      response = WeatherService.daily_weather(39.738453, -104.984853)

      expect(response[0][:dt]).to eq(1619200800)
      expect(response[0][:sunrise]).to eq(1619179818)
      expect(response[0][:sunset]).to eq(1619228742)
      expect(response[0][:temp][:min]).to eq(276.31)
      expect(response[0][:temp][:max]).to eq(286.89)
      expect(response[0][:weather][0][:description]).to eq('light rain')
      expect(response[0][:weather][0][:icon]).to eq('10d')
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