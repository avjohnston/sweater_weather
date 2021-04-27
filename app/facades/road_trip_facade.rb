class RoadTripFacade
  def self.road_trip_object(start_dest, end_dest)
    time = RoadTripService.travel_info(start_dest, end_dest)[:travel_time]
    travel_time = "%02d:%02d:%02d" % [time / 3600, time / 60 % 60, time % 60] if time != 'impossible'
    travel_time = time if time == 'impossible'
    
    data = {
      start_city: start_dest,
      end_city: end_dest,
      travel_time: travel_time,
      weather_at_eta: weather_info(start_dest, end_dest)
    }

    RoadTrip.new(data)
  end

  def self.weather_info(start_dest, end_dest)
    info = RoadTripService.travel_info(start_dest, end_dest)
    return {} if info[:travel_time] == 'impossible'
    hourly = WeatherService.hourly(info[:location][:lat], info[:location][:lng], info[:travel_time])
    daily = WeatherService.daily(info[:location][:lat], info[:location][:lng], info[:travel_time])

    if (info[:travel_time] / 3600) < 48
      {
        temperature: ((hourly[:temp] - 273.15) * 1.8 + 32).round(2).to_s + ' F',
        conditions: hourly[:weather][0][:description]
      }
    else
      {
        temperature: ((daily[:temp][:day] - 273.15) * 1.8 + 32).round(2).to_s + ' F',
        conditions: daily[:weather][0][:description]
      }
    end 
  end
end 