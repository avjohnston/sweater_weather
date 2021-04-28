require 'rails_helper'

RSpec.describe RoadTripFacade, type: :model do
  describe 'class methods' do 
    it '#road_trip_object', :vcr do 
      @response = RoadTripFacade.road_trip_object('los angeles', 'denver')

      expect(@response.class).to eq(RoadTrip)
      expect(@response.end_city).to eq('Denver')
      expect(@response.start_city).to eq('Los Angeles')
      expect(@response.travel_time[0..1].to_i).to be_between(10, 20)
      expect(@response.weather_at_eta[:conditions]).to be_a(String)
      expect(@response.weather_at_eta[:temperature].to_f).to be_between(-20, 110)
    end

    it '#road_trip_object sad path', :vcr do 
      @response = RoadTripFacade.road_trip_object('london', 'denver')
      
      expect(@response).to be_a(RoadTrip)
      expect(@response.end_city).to eq('Denver')
      expect(@response.start_city).to eq('London')
      expect(@response.travel_time).to eq('impossible')
      expect(@response.weather_at_eta).to eq({})
    end

    it '#road_trip_object sad path unreadable', :vcr do 
      @response = RoadTripFacade.road_trip_object('zvcsdewt34', 'denver')

      expect(@response).to be_a(RoadTrip)
      expect(@response.end_city).to eq('Denver')
      expect(@response.start_city).to eq('Zvcsdewt34')
      expect(@response.travel_time).to eq('impossible')
      expect(@response.weather_at_eta).to eq({})
    end

    it '#road_trip_object sad path unreadable end destination', :vcr do 
      @response = RoadTripFacade.road_trip_object('denver', 'vsr435gf')

      expect(@response).to be_a(RoadTrip)
      expect(@response.end_city).to eq('Vsr435gf')
      expect(@response.start_city).to eq('Denver')
      expect(@response.travel_time).to eq('05:36:04')
      expect(@response.weather_at_eta[:temperature][0..1].to_f).to be_between(-20, 110)
      expect(@response.weather_at_eta[:conditions]).to be_a(String)
    end
    
    it '#weather_info', :vcr do 
      @response = RoadTripFacade.weather_info('anchorage', 'denver')

      expect(@response[:temperature].to_f).to be_between(-20, 110)
      expect(@response[:conditions]).to be_a(String)

      @response2 = RoadTripFacade.weather_info('boulder', 'denver')

      expect(@response2[:temperature].to_f).to be_between(-20, 110)
      expect(@response2[:conditions]).to be_a(String)
    end
    
    it '#weather_info sad path', :vcr do 
      @response = RoadTripFacade.weather_info('london', 'denver')
      
      expect(@response).to eq({})
    end 
  end 
end