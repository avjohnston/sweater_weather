require 'rails_helper'

RSpec.describe TeleportService, type: :model do
  describe 'class methods' do 
    it 'should return the city along with attributes', :vcr do 
      @response = TeleportService.get_city_info('gilbert')

    end 

    it '#get_urban_area', :vcr do 
      @response = TeleportService.get_urban_area('aarhus')

    end 

    it 'get_salary_info' do 
      @response = TeleportService.get_salary_info('buffalo')
      require 'pry';binding.pry
    end 
  end 
end