require 'rails_helper'

RSpec.describe 'Api::V1::Sessions Create', type: :request do
  before :each do 
    @user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password')
  end 

  describe 'happy path' do 
    it 'should return a 200 given valid params' do 
      valid_body = {
                      "email": "whatever@example.com",
                      "password": "password"
                    }
        
      post api_v1_sessions_path, params: valid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:type]).to eq('users')
      expect(json[:data][:attributes][:email]).to eq(@user.email)
      expect(json[:data][:attributes][:api_key]).to eq(@user.api_key)
    end 
  end

  describe 'sad path' do 
    it 'should return 400 given invalid params email' do
      invalid_body = {
                      "email": "whatever12321@example.com",
                      "password": "password"
                    }
        
      post api_v1_sessions_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid credentials')
    end 

    it 'should return 400 given invalid params password' do 
      invalid_body = {
                      "email": "whatever@example.com",
                      "password": "password123"
                    }
        
      post api_v1_sessions_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid credentials')
    end 

    it 'should return 400 given no password' do 
      invalid_body = {
                      "email": "whatever@example.com"
                    }
        
      post api_v1_sessions_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid parameters')
    end 

    it 'should return 400 given no email' do 
      invalid_body = {
                      "password": "password123"
                    }
        
      post api_v1_sessions_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq('invalid parameters')
    end 
  end 
end