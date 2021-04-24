class FlickrFacade
  def self.image_objects(text)
    info = FlickrService.get_info(text)

    data = { 
              image: 
                    {
                      location: text,
                      image_url: info[:photo][:urls][:url][0][:_content],
                      credit: { 
                                source: 'https://www.flickr.com/', 
                                author: info[:owner][:username]
                              }
                    }
            }

    Image.new(data)
  end 
end 