require 'rails_helper'

RSpec.describe FlickrFacade, type: :model do
  describe 'class methods' do 
    it '#image_objects', :vcr do 
      @image = FlickrFacade.image_object('denver,co')

      expect(@image).to be_a(Image)
      expect(@image.image).to be_a(Hash)
      expect(@image.image[:location]).to eq('denver,co')
      expect(@image.image[:image_url]).to eq('https://www.flickr.com/photos/denvermarriott/2710497796/')
      expect(@image.image[:credit][:source]).to eq('https://www.flickr.com/')
      expect(@image.image[:credit][:author]).to eq('Denver_Marriott_City_Center')
    end 
  end 
end 
