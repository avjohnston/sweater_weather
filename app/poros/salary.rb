class Salary
  attr_reader :destination,
              :forecast,
              :salaries,
              :id

  def initialize(data)
    @id = nil
    @destination = data[:destination]
    @forecast = data[:forecast]
    @salaries = data[:salaries]
  end 
end 