class ForecastFacade
  def self.location_forecast(location)
    loc = GeocodeService.get_location(location)
    WeatherFacade.weather_objects(loc[:lat], loc[:lng])
  end 
end 