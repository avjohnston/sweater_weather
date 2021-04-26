require 'rails_helper'

RSpec.describe 'Api::V1::Salaries Index', type: :request do
  describe 'happy path' do 
    it 'should return 200 given valid params' do 
      get api_v1_salaries_path, params: { destination: 'denver' }

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:type]).to eq('salaries')
      expect(json[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
      expect(json[:data][:attributes][:destination]).to eq('denver')
      expect(json[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(json[:data][:attributes][:salaries]).to be_an(Array)
      expect(json[:data][:attributes][:salaries].size).to eq(6)
      expect(json[:data][:attributes][:salaries][0].keys).to eq([:title, :min, :max])
    end
  end 

  describe 'sad path' do 
    it 'should return 400 for no params' do 
      get api_v1_salaries_path

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid parameters')
    end 

    it 'should return 400 for an invalid destination' do 
      get api_v1_salaries_path, params: { destination: 'ajwnerput74ufb' }

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid parameters')
    end 

    it 'should return 400 for an empty param' do 
      get api_v1_salaries_path, params: { destination: '' }

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid parameters')
    end 
  end 
end