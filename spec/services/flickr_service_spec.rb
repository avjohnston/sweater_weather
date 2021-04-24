require 'rails_helper'

RSpec.describe FlickrService, type: :model do
  describe '#class methods' do 
    it '#get_id', :vcr do 
      @id = FlickrService.get_id('denver,co')

      expect(@id).to eq('2710497796')
    end
    
    it '#get_info', :vcr do
      @image = FlickrService.get_info('denver,co')

      expect(@image).to be_a(Hash)
      expect(@image[:id]).to eq('2710497796')
      expect(@image[:owner]).to be_a(Hash)
      expect(@image[:owner][:username]).to be_a(String)
      expect(@image[:urls][:url][0][:_content]).to eq("https://www.flickr.com/photos/denvermarriott/2710497796/")
    end
  end 
end
