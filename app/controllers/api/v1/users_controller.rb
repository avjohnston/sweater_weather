class Api::V1::UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.save
      @serial = UsersSerializer.new(@user)

      render json: @serial, status: 201
    else 
      render json: { error: @user.errors.full_messages.uniq }, status: 400
    end 
  end

  private 

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end 