class Api::V1::SalariesController < ApplicationController
  def index 
    if params[:destination]
      @salaries = SalaryFacade.salarie_objects(params[:destination])
      @serial = SalarySerializer.new(@salaries)

      render json: @serial
    else 
      invalid_params
  end 
end 