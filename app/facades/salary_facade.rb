class SalaryFacade 
  def self.salary_objects(destination)
    forecast = {
      summary: ForecastFacade.location_forecast('denver').current_weather[:conditions],
      temperature: ForecastFacade.location_forecast('denver').current_weather[:temperature].to_s + ' F'
    }

    data = {
      destination: destination,
      forecast: forecast,
      salaries: TeleportService.get_salary_info(destination)
    }

    Salary.new(data)
  end 
end 