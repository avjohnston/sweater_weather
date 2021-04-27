class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta,
              :id

  def initialize(data)
    @id = nil
    @start_city = data[:start_city].gsub(',', ', ').titleize
    @end_city = data[:end_city].gsub(',', ', ').titleize
    @travel_time = data[:travel_time]
    @weather_at_eta = data[:weather_at_eta]
  end
  
  # def travel_time
  #   "%02d:%02d:%02d" % [@travel_time / 3600, @travel_time / 60 % 60, @travel_time % 60]
  # end 

  # def temp_to_f(temp)
  #   (((temp.to_i - 273.15) * 1.8) + 32).round(2)
  # end

  # def weather_at_eta
  #   {
  #     temperature: temp_to_f(@weather_at_eta[:temperature]).to_s + ' F',
  #     conditions: @weather_at_eta[:conditions]
  #   }
  # end 
end 