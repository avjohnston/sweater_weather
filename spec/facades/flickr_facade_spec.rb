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
    
    it '#image_objects sad path should return default pic', :vcr do 
      @image = FlickrFacade.image_object('kfsmgni948uhnw')

      expect(@image).to be_a(Image)
      expect(@image.image).to be_a(Hash)
      expect(@image.image[:location]).to eq('kfsmgni948uhnw')
      expect(@image.image[:image_url]).to eq('https://www.flickr.com/photos/captions_by_nica/22377206314/')
      expect(@image.image[:credit][:source]).to eq('https://www.flickr.com/')
      expect(@image.image[:credit][:author]).to eq('(Fieger Photography) Captions by Nica...')
    end 

    it '#image_objects sad path for empty string', :vcr do 
      @image = FlickrFacade.image_object('')
      
      expect(@image).to be_a(Image)
      expect(@image.image).to be_a(Hash)
      expect(@image.image[:location]).to eq('')
      expect(@image.image[:image_url]).to eq('https://www.flickr.com/photos/captions_by_nica/22377206314/')
      expect(@image.image[:credit][:source]).to eq('https://www.flickr.com/')
      expect(@image.image[:credit][:author]).to eq('(Fieger Photography) Captions by Nica...')
    end
  end 
end 
