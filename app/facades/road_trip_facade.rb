class RoadTripFacade
  def self.road_trip_object(start_dest, end_dest)
    time = RoadTripService.get_travel_time(start_dest, end_dest)
    
    data = {
      start_city: start_dest,
      end_city: end_dest,
      travel_time: time,
      weather_at_eta: weather_info(start_dest, end_dest)
    }

    RoadTrip.new(data)
  end

  def self.weather_info(start_dest, end_dest)
    info = RoadTripService.travel_info(start_dest, end_dest)
    hourly = WeatherService.hourly(info[:location][:lat], info[:location][:lng], info[:travel_time])
    daily = WeatherService.daily(info[:location][:lat], info[:location][:lng], info[:travel_time])

    if (info[:travel_time] / 3600) < 48
      {
        temperature: hourly[:temp],
        conditions: hourly[:weather][0][:description]
      }
    else
      {
        temperature: daily[:temp][:day],
        conditions: daily[:weather][0][:description]
      }
    end 
  end
end 