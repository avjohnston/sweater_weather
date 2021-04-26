class WeatherService
  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end 

  def self.get_weather(lat, lon)
    response = conn.get('/data/2.5/onecall') do |f|
      f.params['appid'] = ENV['weather_key']
      f.params['lat'] = lat
      f.params['lon'] = lon
    end 
    parse(response)
  end

  def self.memo(lat, lon)
    response ||= self.get_weather(lat, lon)
  end 
  
  def self.current_weather(lat, lon)
    memo(lat, lon)[:current]
  end

  def self.hourly_weather(lat, lon)
    memo(lat, lon)[:hourly].first(8)
  end 

  def self.daily_weather(lat, lon)
    memo(lat, lon)[:daily].first(5)
  end 

  def self.hourly(lat, lon, time)
    WeatherService.memo(lat, lon)[:hourly].find_all do |hour|
      hour[:dt] <= Time.now.to_i + time
    end.last
  end 

  def self.daily(lat, lon, time)
    WeatherService.memo(lat, lon)[:daily].find_all do |hour|
      hour[:dt] <= Time.now.to_i + time
    end.last
  end 
end 