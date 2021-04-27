class FlickrService
def self.conn
    Faraday.new(url: 'https://www.flickr.com')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end 

  def self.get_id(text)
    response = conn.get('/services/rest') do |f|
      f.params['method'] = 'flickr.photos.search'
      f.params['api_key'] = ENV['flickr_key']
      f.params['text'] = text + 'skyline'
      f.params['per_page'] = 1
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
    end 
    return '22377206314' if parse(response)[:photos][:total] == '0' || text == ''
    parse(response)[:photos][:photo][0][:id]
  end

  def self.get_info(text)
    response = conn.get('/services/rest') do |f|
      f.params['api_key'] = ENV['flickr_key']
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
      f.params['method'] = 'flickr.photos.getInfo'
      f.params['photo_id'] = get_id(text)
    end 
    parse(response)[:photo]
  end
end 