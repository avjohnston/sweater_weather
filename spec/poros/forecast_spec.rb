require 'rails_helper'

RSpec.describe Forecast, type: :model do
  it 'should return a forecast object with the correct data' do 
    attributes = {
      current: 'sunny',
      hourly: 'rainy',
      daily: 'snowy'
    }

    @forecast = Forecast.new(attributes)

    expect(@forecast).to be_a(Forecast)
    expect(@forecast.id).to eq(nil)
    expect(@forecast.current_weather).to eq('sunny')
    expect(@forecast.hourly_weather).to eq('rainy')
    expect(@forecast.daily_weather).to eq('snowy')
  end 
end