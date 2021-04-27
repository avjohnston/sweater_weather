require 'rails_helper'

RSpec.describe 'Api::V1::RoadTrips Create', type: :request do
  before :each do 
    @user = User.create(email: 'email@email.com', password: 'password', api_key: 'nsFDAw34VDy723wu')
  end 

  describe 'happy path' do 
    it 'should return a 201 with valid body', :vcr do 
      valid_body = {
                      "origin": "denver,co",
                      "destination": "pueblo,co",
                      "api_key": @user.api_key
                    }

      post api_v1_road_trip_path, params: valid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(201)
      
      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:type]).to eq('road_trip')
      expect(json[:data][:attributes][:start_city]).to eq('Denver, Co')
      expect(json[:data][:attributes][:end_city]).to eq('Pueblo, Co')
      expect(json[:data][:attributes][:travel_time]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end 
  end 

  describe 'sad path' do 
    it 'should return 401 if the api key doesnt belong to a user', :vcr do 
      invalid_body = {
                      "origin": "denver,co",
                      "destination": "pueblo,co",
                      "api_key": 'diffapikey'
                    }

      post api_v1_road_trip_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(401)

      expect(json[:error]).to eq('invalid api key')
    end 
    
    it 'should return travel time as impossible if the route cant be driven', :vcr do
      invalid_body = {
                      "origin": "denver,co",
                      "destination": "london,uk",
                      "api_key": @user.api_key
                    }

      post api_v1_road_trip_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(201)
      
      expect(json[:data][:type]).to eq('road_trip')
      expect(json[:data][:attributes][:start_city]).to eq('Denver, Co')
      expect(json[:data][:attributes][:end_city]).to eq('London, Uk')
      expect(json[:data][:attributes][:travel_time]).to eq('impossible')
      expect(json[:data][:attributes][:weather_at_eta]).to eq({})
    end
  end 
end