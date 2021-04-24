class Api::V1::ImagesController < ApplicationController
  def show
    if params[:location]
      @image = FlickrFacade.image_object(params[:location])
      @serial = ImageSerializer.new(@image)

      render json: @serial
    else 
      invalid_params
    end 
  end 
end 