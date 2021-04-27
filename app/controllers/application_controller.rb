class ApplicationController < ActionController::API
  def invalid_params
    render json: { data: {}, error: 'invalid parameters'}, status: 400
  end 

  def bad_api?
    !trip_params[:api_key] || User.where(api_key: trip_params[:api_key]).empty?
  end

  def invalid_locations?
    (!trip_params[:origin] || !trip_params[:destination]) ||
    (trip_params[:origin] == '' || trip_params[:destination] == '')
  end
end
