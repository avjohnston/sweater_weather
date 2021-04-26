require 'rails_helper'

RSpec.describe 'Api::V1::Salaries Index', type: :request do
  describe 'happy path' do 
    it 'should return 200 given valid params', :vcr do 
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
end