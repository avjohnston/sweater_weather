require 'rails_helper'

RSpec.describe RoadTripService, type: :model do
  describe 'class methods' do 
    it '#get_travel_info', :vcr do 
      @response = RoadTripService.get_travel_info('denver', 'boulder')

      expect(@response).to be_a(Hash)
      expect(@response[:formattedTime]).to eq('00:35:23')
      expect(@response.keys.include?(:locations)).to eq(true)
      expect(@response[:locations]).to be_an(Array)
      expect(@response[:locations][1]).to be_a(Hash)
      expect(@response[:locations][1][:latLng].keys).to eq([:lng, :lat])
    end 

    it '#get_travel_time', :vcr do 
      @response = RoadTripService.get_travel_time('denver', 'boulder')
      
      expect(@response).to eq(2123)
    end

    it '#get_location', :vcr do 
      @response = RoadTripService.get_location('denver', 'boulder')

      expect(@response[:lng]).to eq(-105.279266)
      expect(@response[:lat]).to eq(40.015831)
    end
  end
end

