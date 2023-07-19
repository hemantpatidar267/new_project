class AuthenticationController < ApiController
  skip_before_action :authenticate_request
  def login
  	# debugger
  	# puts params
    @user = User.find_by(email: params[:email])

    if @user && @user.password == params[:password]
      token = jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end

  
