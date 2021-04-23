class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = data[:current]
    @hourly_weather = data[:hourly]
    @daily_weather = data[:daily]
  end 
end 