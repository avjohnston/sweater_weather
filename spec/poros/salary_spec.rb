require 'rails_helper'

RSpec.describe Salary, type: :model do
  describe 'happy path' do 
    it 'creates a poro with valid attributes' do 
      forecast = {
          summary: 'partly cloudy',
          temperature: '89 F'
        }

        salaries = [
          {
            title: 'Job',
            min: '$40.00',
            max: '&50.00'
          }
        ]

      valid_attributes = {
        destination: 'denver',
        forecast: forecast,
        salaries: salaries
      }

      @salary = Salary.new(valid_attributes)

      expect(@salary.id).to eq(nil)
      expect(@salary.destination).to eq('denver')
      expect(@salary.forecast).to eq(forecast)
      expect(@salary.salaries).to eq(salaries)
    end 
  end 
end