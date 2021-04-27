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

    it '#get_travel_info sad path bad string', :vcr do 
      @response = RoadTripService.get_travel_info('caaw4$%', 'boulder')
      
      expect(@response).to eq([false, "impossible route"])
    end 

    it '#get_travel_info sad path impossible route', :vcr do 
      @response = RoadTripService.get_travel_info('london', 'boulder')
      
      expect(@response).to eq([false, "impossible route"])
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

    it '#travel_info', :vcr do 
      @response = RoadTripService.travel_info('denver', 'boulder')

      expect(@response[:travel_time]).to eq(2123)
      expect(@response[:start_dest]).to eq('denver')
      expect(@response[:end_dest]).to eq('boulder')
      expect(@response[:location][:lng]).to eq(-105.279266)
      expect(@response[:location][:lat]).to eq(40.015831)
    end

    it '#travel_info sad path', :vcr do 
      @response = RoadTripService.travel_info('london', 'boulder')

      expect(@response[:travel_time]).to eq('impossible')
      expect(@response[:start_dest]).to eq('london')
      expect(@response[:end_dest]).to eq('boulder')
      expect(@response[:location]).to eq('')
    end 
  end
end

