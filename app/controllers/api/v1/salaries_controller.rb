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

  def valid_destination?(destination)
    return false if TeleportService.get_salary_link(destination).empty?
    true
  end 
end 