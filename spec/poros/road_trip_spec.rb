require 'rails_helper'

RSpec.describe RoadTrip, type: :model do
  before :each do 
    @weather = {
      temperature: 273.15,
      conditions: 'partly cloudy'
    }

    @attributes = {
      start_city: 'denver',
      end_city: 'boulder',
      travel_time: 3550,
      weather_at_eta: @weather
    }
  end

  describe 'class' do 
    it 'should return a roadtrip object with the correct attributes' do 
      @trip = RoadTrip.new(@attributes)
      
      expect(@trip.start_city).to eq('Denver')
      expect(@trip.end_city).to eq('Boulder')
      expect(@trip.travel_time).to eq('00:59:10')
      expect(@trip.weather_at_eta).to eq({:conditions=>"partly cloudy", :temperature=>"31.73 F"})
    end 
  end 

  describe 'methods' do 
    it '#travel_time' do 
      @trip = RoadTrip.new(@attributes)

      expect(@trip.travel_time).to eq('00:59:10')
    end 

    it '#weather_at_eta' do 
      @trip = RoadTrip.new(@attributes)

      expect(@trip.weather_at_eta).to eq({:conditions=>"partly cloudy", :temperature=>"31.73 F"})
    end 
  end 
end