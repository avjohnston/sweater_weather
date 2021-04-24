class Api::V1::SessionsController < Api::V1::UsersController
  def create
    @user = User.find_by(email: user_params[:email])
    if !@user.nil? && @user.authenticate(user_params[:password])
      @serial = UsersSerializer.new(@user)

      render json: @serial, status: 200
    else 
      render json: { error: 'invalid credentials' }, status: 400
    end
  end
end 