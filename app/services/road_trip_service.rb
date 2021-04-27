class RoadTripService
  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end 

  def self.get_travel_info(start_dest, end_dest)
    response = conn.get('/directions/v2/route') do |f|
      f.params['key'] = ENV['geo_key']
      f.params['from'] = start_dest
      f.params['to'] = end_dest
    end
    return [] if parse(response)[:route][:routeError][:errorCode] == 2
    parsed ||= parse(response)[:route]
  end

  def self.get_travel_time(start_dest, end_dest)
    get_travel_info(start_dest, end_dest)[:time]
  end 

  def self.get_location(start_dest, end_dest)
    get_travel_info(start_dest, end_dest)[:locations][1][:displayLatLng]
  end 

  def self.travel_info(start_dest, end_dest)
    info = get_travel_info(start_dest, end_dest)
    {
      travel_time: info[:time],
      start_dest: start_dest,
      end_dest: end_dest,
      location: info[:locations][1][:displayLatLng]
    }
  end 
end 