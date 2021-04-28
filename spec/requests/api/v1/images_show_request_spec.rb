require 'rails_helper'

RSpec.describe 'Api::V1::Images Show', type: :request do
  describe 'happy path' do 
    it 'should return a 200 with the correct attributes for valid parameters', :vcr do 
      get api_v1_backgrounds_path, params: { location: 'denver,co' }

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data][:type]).to eq('image')
      expect(json[:data][:attributes][:image].keys).to eq([:location, :image_url, :credit])
      expect(json[:data][:attributes][:image][:credit].keys).to eq([:source, :author])
    end
  end 

  describe 'sad path' do 
    it 'should return 400 if params are invalid', :vcr do 
      get api_v1_backgrounds_path

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid parameters')
    end
    
    it 'an invalid parameter should still return 200 with a default pic', :vcr do 
      get api_v1_backgrounds_path, params: { location: 'fsjnepiuhfnio84758' }

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)

      expect(json[:data][:attributes][:image][:image_url]).to eq('https://www.flickr.com/photos/captions_by_nica/22377206314/')
    end 

    it 'an empty parameter should still return 200 with a default pic', :vcr do 
      get api_v1_backgrounds_path, params: { location: '' }

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)

      expect(json[:data][:attributes][:image][:image_url]).to eq('https://www.flickr.com/photos/captions_by_nica/22377206314/')
    end
  end 
end
