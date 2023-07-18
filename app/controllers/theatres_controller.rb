# frozen_string_literal: true

# managing theatre
class TheatresController < ApplicationController
  before_action :check_user, only: [:create, :update, :destroy]
  before_action :set_theatre, only: [:show, :update]
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
    render json:  @theatre, status: :ok
  end

  def update
    if @theatre.update(theatre_params)
      render json: @theatre, status: :ok
    else
      render json: @theatre.errors, status: :unprocessable_entity
    end
  end

  def index
    theaters = Theatre.all
    render json: { theaters: theaters }
  end

  private

  def theatre_params
    params.permit(:name, :address, :image)
  end

  def set_theatre
    @theatre = Theatre.find_by(id: params[:id])
    render json: { message: 'theatre not found' }, status: :not_found unless @theatre
  end

  def check_user
    if !@current_user.user
      render json: { error: 'not Allowed' }
    end
  end
end
