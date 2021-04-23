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
        parse(response)[:results][0][:locations][0][:latLng]
    end 
end 