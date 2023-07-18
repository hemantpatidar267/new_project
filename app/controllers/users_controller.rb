# frozen_string_literal: true

# managing user
class UsersController < ApplicationController
  skip_before_action :authenticate_request
  before_action :set_user, only: [:show, :update]
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
    render json: @user, status: :ok
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    render json: { users: users }
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { message: 'user not found' }, status: :not_found unless @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :user, :role)
  end
end
