# frozen_string_literal: true

# managing user
class UsersController < ApiController
  #skip_before_action :authenticate_request
  # before_action :set_user, only: [:show, :update]
  # Service to download ftp files from the
  def create
    user = User.new(user_params)
    if user.save
      render json: { user: user }, status: :created
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def show
    render json: @current_user, status: :ok
  end

  def update
    user = @current_user
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  # def set_user
  #   @user = User.find_by(id: params[:id])
  #   render json: { message: 'user not found' }, status: :not_found unless @user
  # end

  def user_params
    params.permit(:name, :email, :password, :user, :role)
  end
end
