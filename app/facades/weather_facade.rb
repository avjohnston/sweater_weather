class WeatherFacade
  def self.weather_objects(lat, lon)
    data = {
      current: current_attribute(lat, lon),
      hourly: hourly_attribute(lat, lon),
      daily: daily_attribute(lat, lon)
    }
    Forecast.new(data)
  end

  def self.current_attribute(lat, lon)
    current = WeatherService.current_weather(lat, lon)
    {
      datetime: Time.at(current[:dt]).strftime('%a %b %e, %Y %I:%M%P'),
      sunrise: Time.at(current[:sunrise]).strftime('%I:%M%P'),
      sunset: Time.at(current[:sunset]).strftime('%I:%M%P'),
      temperature: temp_to_f(current[:temp]),
      feels_like: temp_to_f(current[:feels_like]),
      humidity: current[:humidity],
      uvi: current[:uvi],
      visibility: current[:visibility],
      conditions: current[:weather][0][:description],
      icon: current[:weather][0][:icon]
    }
  end 

  def self.hourly_attribute(lat, lon)
    WeatherService.hourly_weather(lat, lon).map do |cast|
      {
        time: Time.at(cast[:dt]).strftime('%I:%M%P'),
        temperature: temp_to_f(cast[:temp]),
        conditions: cast[:weather][0][:description],
        icon: cast[:weather][0][:icon]
      }
    end 
  end

  def self.daily_attribute(lat, lon)
    WeatherService.daily_weather(lat, lon).map do |cast|
      {
        datetime: Time.at(cast[:dt]).strftime('%F'),
        sunrise: Time.at(cast[:sunrise]).strftime('%I:%M%P'),
        sunset: Time.at(cast[:sunset]).strftime('%I:%M%P'),
        max_temp: temp_to_f(cast[:temp][:max]),
        min_temp: temp_to_f(cast[:temp][:min]),
        conditions: cast[:weather][0][:description],
        icon: cast[:weather][0][:icon]
      }
    end 
  end
  
  def self.temp_to_f(temp)
    (((temp.to_i - 273.15) * 1.8) + 32).round(2)
  end
end 