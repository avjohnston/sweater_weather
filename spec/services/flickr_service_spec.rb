require 'rails_helper'

RSpec.describe FlickrService, type: :model do
  describe '#class methods' do 
    it '#get_id', :vcr do 
      @id = FlickrService.get_id('denver,co')

      expect(@id).to eq('2710497796')
    end

    it '#get_id sad path empty string wont break', :vcr do 
      @id = FlickrService.get_id('')

      expect(@id).to eq('22377206314')
    end 
    
    it '#get_info', :vcr do
      @image = FlickrService.get_info('denver,co')

      expect(@image).to be_a(Hash)
      expect(@image[:id]).to eq('2710497796')
      expect(@image[:owner]).to be_a(Hash)
      expect(@image[:owner][:username]).to be_a(String)
      expect(@image[:urls][:url][0][:_content]).to eq("https://www.flickr.com/photos/denvermarriott/2710497796/")
    end

    it '#get_info sad path empty string will use default pic', :vcr do 
      @image = FlickrService.get_info('')
      
      expect(@image[:id]).to eq('22377206314')
      expect(@image[:owner]).to be_a(Hash)
      expect(@image[:owner][:username]).to be_a(String)
      expect(@image[:urls][:url][0][:_content]).to eq("https://www.flickr.com/photos/captions_by_nica/22377206314/")
    end 
  end 
end
