class Api::V1::SalariesController < ApplicationController
  def index 
    if params[:destination] && valid_destination?(params[:destination])
      @salaries = SalaryFacade.salary_objects(params[:destination])
      @serial = SalariesSerializer.new(@salaries)

      render json: @serial
    else 
      invalid_params
    end 
  end 

  private 

  def valid_destination?(search)
    return false if TeleportService.get_city_link(search).empty?
    true
  end 
end 