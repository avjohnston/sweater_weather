class Api::V1::SalariesController < ApplicationController
  def index 
    if params[:destination]
      @salaries = SalaryFacade.salary_objects(params[:destination])
      @serial = SalariesSerializer.new(@salaries)

      render json: @serial
    else 
      invalid_params
    end 
  end 
end 