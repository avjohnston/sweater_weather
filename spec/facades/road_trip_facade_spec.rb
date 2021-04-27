require 'rails_helper'

RSpec.describe RoadTripFacade, type: :model do
  describe 'class methods' do 
    it '#road_trip_object', :vcr do 
      @response = RoadTripFacade.road_trip_object('los angeles', 'denver')

      expect(@response.class).to eq(RoadTrip)
      expect(@response.end_city).to eq('Denver')
      expect(@response.start_city).to eq('Los Angeles')
      expect(@response.travel_time).to eq("14:24:24")
      expect(@response.weather_at_eta).to eq({:temperature=>'56.77 F', :conditions=>"overcast clouds"})
    end
    
    it '#weather_info', :vcr do 
      @response = RoadTripFacade.weather_info('anchorage', 'denver')

      expect(@response[:temperature]).to eq('55.0 F')
      expect(@response[:conditions]).to eq('moderate rain')

      @response2 = RoadTripFacade.weather_info('boulder', 'denver')

      expect(@response2[:temperature]).to eq('73.96 F')
      expect(@response2[:conditions]).to eq('overcast clouds')
    end 
  end 
end