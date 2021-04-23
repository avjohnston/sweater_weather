require 'rails_helper'

RSpec.describe ForecastFacade, type: :model do
  describe 'class methods' do 
    it '#location_forecast', :vcr do 
      @forecast = ForecastFacade.location_forecast('denver,co')

      expect(@forecast).to be_a(Forecast)
    end
  end 
end