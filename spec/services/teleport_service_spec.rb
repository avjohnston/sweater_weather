require 'rails_helper'

RSpec.describe TeleportService, type: :model do
  describe 'class methods' do 
    it '#get_city' do 
      @response = TeleportService.get_city_link('denver')
      
      expect(@response).to eq('https://api.teleport.org/api/cities/geonameid:5419384/')
    end 

    it '#get_urban_area_link' do 
      @response = TeleportService.get_urban_area_link('denver')

      expect(@response).to eq('https://api.teleport.org/api/urban_areas/slug:denver/')
    end 

    it '#get_salary_link' do 
      @response = TeleportService.get_salary_link('denver')

      expect(@response).to eq('https://api.teleport.org/api/urban_areas/slug:denver/salaries/')
    end 

    it '#get_salary_info' do 
      @response = TeleportService.get_salary_info('denver')

      expect(@response).to be_an(Array)
      expect(@response[0][:title]).to eq('Data Analyst')
      expect(@response[0][:min]).to eq('$42,878.34')
      expect(@response[0][:max]).to eq('$62,106.69')
    end 
  end 
end