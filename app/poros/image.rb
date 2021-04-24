class Image
  attr_reader :image

  def initialize(data)
    @id = nil
    @image = data[:image]
  end 
end 