require 'rails_helper'

RSpec.describe SalaryFacade, type: :model do
  describe 'class methods' do 
    it '#salary_objects' do 
      @salary = SalaryFacade.salary_objects('denver')

      expect(@salary).to be_a(Salary)
      expect(@salary.destination).to eq('denver')
      expect(@salary.forecast.keys).to eq([:summary, :temperature])
      expect(@salary.salaries.size).to eq(6)
      expect(@salary.salaries[0].keys).to eq([:title, :min, :max])
    end 
  end 
end