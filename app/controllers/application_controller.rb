class ApplicationController < ActionController::API
  def invalid_params
    render json: { data: {}, error: 'invalid parameters'}, status: 400
  end 
end
