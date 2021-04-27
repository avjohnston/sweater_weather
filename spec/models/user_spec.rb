require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do 
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end
  
  describe 'instance methods' do 
    it '#update_api_key' do 
      @user = User.create(email: 'email@email.com', password: 'password')
      @user.update_api_key

      expect(@user.api_key).to be_a(String)
    end 
  end 
end