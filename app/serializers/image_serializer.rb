class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :image
end
