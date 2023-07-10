class UsersController < ApplicationController

  def create
    #byebug
    user = User.new(user_params)
    if user.save
      render json: { user: user }, status: :created
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id:params[:id])
    render json: { user: user }
  end


  def update
    byebug
    user = User.find_by(id:params[:id])

    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :user, :role)
  end
end


# List all Theaters
# before_action :authorize_owner
# theaters = @current_user.theaters
# result = []
# theaters.each do |t|
#   h = Hash.new
#    h[:title] = t.name
# .
# .
# .
#    result.push(h)
#  end

#    render json: result