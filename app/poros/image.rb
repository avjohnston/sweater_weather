class Image
  attr_reader :id,
              :image

  def initialize(data)
    @id = nil
    @image = data[:image]
  end 
end