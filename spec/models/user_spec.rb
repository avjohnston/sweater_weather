require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @data = {
            "email": "whatever@example.com",
            "password": "password",
            "password_confirmation": "password"
          }
    @user = User.create(@data)
  end

  describe 'instance_methods' do 
    it '#default_api' do
      expect(@user.default_api).to be_a(String)
    end 
  end
  
end