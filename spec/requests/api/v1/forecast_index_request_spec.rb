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
      expect(json[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      expect(json[:data][:attributes][:current_weather].keys.count).to eq(10)
    end 

    it 'should return current weather all correctly formatted' do 
      VCR.use_cassette('Api_V1_Forecast_index/happy_path/should_return_a_status_of_200_and_correct_attributes_given_valid_params') do
        get api_v1_forecast_path, params: { location: 'denver, co' }

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)

        expect(json[:data][:attributes][:current_weather][:datetime]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:sunset]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
        expect(json[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
        expect(json[:data][:attributes][:current_weather][:humidity]).to be_an(Integer)
        expect(json[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
        expect(json[:data][:attributes][:current_weather][:visibility]).to be_an(Integer)
        expect(json[:data][:attributes][:current_weather][:conditions]).to be_a(String)
        expect(json[:data][:attributes][:current_weather][:icon]).to be_a(String)
      end

      
    end 

    it 'should return daily weather all correctly formatted' do 
      VCR.use_cassette('Api_V1_Forecast_index/happy_path/should_return_a_status_of_200_and_correct_attributes_given_valid_params') do
        get api_v1_forecast_path, params: { location: 'denver, co' }

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)

        expect(json[:data][:attributes][:daily_weather][0][:datetime]).to be_a(String)
        expect(json[:data][:attributes][:daily_weather][0][:sunrise]).to be_a(String)
        expect(json[:data][:attributes][:daily_weather][0][:sunset]).to be_a(String)
        expect(json[:data][:attributes][:daily_weather][0][:max_temp]).to be_a(Float)
        expect(json[:data][:attributes][:daily_weather][0][:min_temp]).to be_a(Float)
        expect(json[:data][:attributes][:daily_weather][0][:conditions]).to be_a(String)
        expect(json[:data][:attributes][:daily_weather][0][:icon]).to be_a(String)
      end
    end

    it 'should return hourly weather all correctly formatted' do 
      VCR.use_cassette('Api_V1_Forecast_index/happy_path/should_return_a_status_of_200_and_correct_attributes_given_valid_params') do
        get api_v1_forecast_path, params: { location: 'denver, co' }

        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)

        expect(json[:data][:attributes][:hourly_weather][0][:time]).to be_a(String)
        expect(json[:data][:attributes][:hourly_weather][0][:temperature]).to eq(51.53)
        expect(json[:data][:attributes][:hourly_weather][0][:conditions]).to be_a(String)
        expect(json[:data][:attributes][:hourly_weather][0][:icon]).to be_a(String)
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