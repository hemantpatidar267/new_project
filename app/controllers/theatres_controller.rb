# frozen_string_literal: true

# managing theatre
class TheatresController < ApplicationController
  before_action :authorize_owner, only: [:create, :update, :destroy]
  # Service to download ftp files from the
  def create
    theatre = @current_user.theatres.new(theatre_params)
    if theatre.save
      render json: theatre, status: :created
    else
      render json: theatre.errors, status: :unprocessable_entity
    end
  end

  def show
    theatre = Theatre.find_by(id: params[:id])
    render json:  theatre
  end

  def update
    theatre = Theatre.find_by(id: params[:id])
    if theatre.update(theatre_params)
      render json: theatre, status: :ok
    else
      render json: theatre.errors, status: :unprocessable_entity
    end
  end

  def destroy
    theatre = Theatre.find_by(id: params[:id])
    if theatre.destroy
      render json: { message: 'Theatre successfully deleted' }, status: :ok
    else
      render json: { error: 'Failed to delete theatre' }, status: :unprocessable_entity
    end
  end

  def index
    theaters = Theatre.all
    render json: { theaters: theaters } 
  end

  private

  def theatre_params
    params.require(:theatre).permit(:name, :address)
  end

  def authorize_owner
    user = User.find_by(id: @current_user.id)
    if user
      if user.user
        puts user.user
      else
        render json: { error: 'you do not have powers' }, status: :unauthorized
      end
    else
      render json: { error: 'you are not a valid user' }, status: :unauthorized
    end
  end
end
