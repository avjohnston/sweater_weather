require 'rails_helper'

RSpec.describe Image, type: :model do
  it 'should create an image with the correct attributes' do 
    attributes = {
                    image: 
                          {
                            location: 'denver,co',
                            image_url: 'www.flickr.com',
                            credit: { 
                                      source: 'https://www.flickr.com/', 
                                      author: 'quinntheeskimo'
                                    }
                          }
                   }
    @image = Image.new(attributes)

    expect(@image.id).to eq(nil)
    expect(@image.image).to eq(attributes[:image])
  end 
end
