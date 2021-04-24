require 'rails_helper'

RSpec.describe 'Api::V1::Forecast Index', type: :request do
  describe 'happy path' do 
    it 'should return a status of 200 and correct attributes given valid params', :vcr do 
      get api_v1_forecast_path, params: { location: 'denver, co' }

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:type]).to eq('forecast')
      expect(json[:data][:attributes]).to be_an(Hash)
      expect(json[:data][:attributes].keys).to eq([:id, :current_weather, :daily_weather, :hourly_weather])
      expect(json[:data][:attributes][:current_weather].keys.count).to eq(10)
    end 

    it 'should return current weather all correctly formatted' do 
      VCR.use_cassette('Api_V1_Forecast_index/happy_path/should_return_a_status_of_200_and_correct_attributes_given_valid_params') do
        get api_v1_forecast_path, params: { location: 'denver, co' }

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)

        expect(json[:data][:attributes][:current_weather][:datetime]).to eq('Fri Apr 23, 2021 04:44pm')
        expect(json[:data][:attributes][:current_weather][:sunrise]).to eq('06:10am')
        expect(json[:data][:attributes][:current_weather][:sunset]).to eq('07:45pm')
        expect(json[:data][:attributes][:current_weather][:temperature]).to eq(53.33)
        expect(json[:data][:attributes][:current_weather][:feels_like]).to eq(49.73)
        expect(json[:data][:attributes][:current_weather][:humidity]).to eq(29)
        expect(json[:data][:attributes][:current_weather][:uvi]).to eq(1.67)
        expect(json[:data][:attributes][:current_weather][:visibility]).to eq(10000)
        expect(json[:data][:attributes][:current_weather][:conditions]).to eq('broken clouds')
        expect(json[:data][:attributes][:current_weather][:icon]).to eq('04d')
      end
    end 

    it 'should return daily weather all correctly formatted' do 
      VCR.use_cassette('Api_V1_Forecast_index/happy_path/should_return_a_status_of_200_and_correct_attributes_given_valid_params') do
        get api_v1_forecast_path, params: { location: 'denver, co' }

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)

        expect(json[:data][:attributes][:daily_weather][0][:datetime]).to eq('2021-04-23')
        expect(json[:data][:attributes][:daily_weather][0][:sunrise]).to eq('06:10am')
        expect(json[:data][:attributes][:daily_weather][0][:sunset]).to eq('07:45pm')
        expect(json[:data][:attributes][:daily_weather][0][:max_temp]).to eq(55.13)
        expect(json[:data][:attributes][:daily_weather][0][:min_temp]).to eq(37.13)
        expect(json[:data][:attributes][:daily_weather][0][:conditions]).to eq('light rain')
        expect(json[:data][:attributes][:daily_weather][0][:icon]).to eq('10d')
      end
    end

    it 'should return hourly weather all correctly formatted' do 
      VCR.use_cassette('Api_V1_Forecast_index/happy_path/should_return_a_status_of_200_and_correct_attributes_given_valid_params') do
        get api_v1_forecast_path, params: { location: 'denver, co' }

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)

        expect(json[:data][:attributes][:hourly_weather][0][:time]).to eq('04:00pm')
        expect(json[:data][:attributes][:hourly_weather][0][:temperature]).to eq(51.53)
        expect(json[:data][:attributes][:hourly_weather][0][:conditions]).to eq('light rain')
        expect(json[:data][:attributes][:hourly_weather][0][:icon]).to eq('10d')
      end
    end 
  end
  
  describe 'sad path' do 
    it 'should return 400 for no params', :vcr do 
      get api_v1_forecast_path

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid parameters')
    end
    
    it 'should return 400 for invalid params', :vcr do 
      get api_v1_forecast_path, params: { location: '' }

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid parameters')
    end 
  end 
end