require 'rails_helper'

RSpec.describe TeleportService, type: :model do
  describe 'class methods' do 
    it '#get_salary_link' do 
      @response = TeleportService.get_salary_link('denver')
      expect(@response).to eq('https://api.teleport.org/api/urban_areas/slug:denver/salaries/')
      
      @response2 = TeleportService.get_salary_link('varen4734h')
      expect(@response2).to eq([])
    end

    it '#get_salary_info' do 
      @response = TeleportService.get_salary_info('denver')

      expect(@response).to be_an(Array)
      expect(@response.size).to eq(6)
      expect(@response[0][:title]).to eq('Data Analyst')
      expect(@response[0][:min]).to eq('$42878.34')
      expect(@response[0][:max]).to eq('$62106.69')
    end 
  end 
end