class Api::V1::UsersController < ApplicationController
  def create
    if user_params[:email]
      new_params = user_params
      new_params[:email] = user_params[:email].downcase
    else 
      return render json: { error: "Email can't be blank" }, status: 400
    end

    @user = User.create(new_params)
    if @user.save
      @user.update_api_key
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