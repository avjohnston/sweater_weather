require 'rails_helper'

RSpec.describe 'Api::V1::Users Create', type: :request do
  describe 'happy path' do 
    it 'should return 201 given valid body' do 
      valid_body = {
                      "email": "whatever@example.com",
                      "password": "password",
                      "password_confirmation": "password"
                    }
        
      post api_v1_users_path, params: valid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(201)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:type]).to eq('users')
      expect(json[:data][:attributes][:email]).to eq('whatever@example.com')
      expect(json[:data][:attributes][:api_key]).to be_a(String)
    end 
  end

  describe 'sad path' do 
    it 'it should return 400 with error email already exists' do 
      @user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password')
      invalid_body = {
                      "email": "whatever@example.com",
                      "password": "password",
                      "password_confirmation": "password"
                    }
      
      post api_v1_users_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq(['Email has already been taken'])
    end 

    it 'it should return 400 with error passwords dont match' do 
      @user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password')
      invalid_body = {
                      "email": "whatever4@example.com",
                      "password": "password",
                      "password_confirmation": "password123"
                    }
      
      post api_v1_users_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)
      
      expect(json[:error]).to eq(["Password confirmation doesn't match Password"])
    end 

    it 'it should return 400 for missing email' do 
      invalid_body = {
                      "email": "whatever@example.com",
                      "password": "password",
                      "password_confirmation": "password123"
                    }
      
      post api_v1_users_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq(["Password confirmation doesn't match Password"])
    end 

    it 'it should return 400 for missing password' do 
      invalid_body = {
                        "email": "whatever@example.com",
                        "password": "password",
                        "password_confirmation": "password123"
                      }
      
      post api_v1_users_path, params: invalid_body
      request.headers['Content-Type'] = 'application/json'
      request.headers['Accept'] = 'application/json'
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(400)

      expect(json[:error]).to eq(["Password confirmation doesn't match Password"])
    end
  end 
end