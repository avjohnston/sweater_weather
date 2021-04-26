class SalaryFacade 
  def self.salary_objects(search)
    forecast = {
      summary: ForecastFacade.location_forecast('denver').current_weather[:conditions],
      temperature: ForecastFacade.location_forecast('denver').current_weather[:temperature].to_s + ' F'
    }

    data = {
      destination: search,
      forecast: forecast,
      salaries: TeleportService.get_salary_info(search)
    }

    Salary.new(data)
  end 
end 