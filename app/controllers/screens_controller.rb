# frozen_string_literal: true

# managing screen
class ScreensController < ApiController
  before_action :check_user, only: %i[create update destroy]
  # Service to download ftp files from the
  def create
    screen = Screen.new(screen_params)
    if screen.save
      render json: screen, status: :created
    else
      render json: screen.errors, status: :unprocessable_entity
    end
  end

  def show
    screen = Screen.find_by(id: params[:id])
    if screen.present?
      render json: screen
    else
      render json: { message: 'screen not found' }
    end
  end

  def update
    screen = @current_user.screens.find_by(id: params[:id])
    if screen.update(screen_params)
      render json: screen, status: :ok
    end
    rescue NoMethodError
      render json: {message: 'screen not found' }
  end

  def destroy
    screen = @current_user.screens.find_by(id: params[:id])
    if screen.destroy
      render json: { message: 'screen successfully deleted' }, status: :ok
    end
    rescue NoMethodError
      render json: {message: 'screen not found' }
  end

  def index
    theatre = Theatre.find_by(id: params[:id])
    if theatre.present?
      screens = theatre.screens
      if screens.empty?
        render json: { message: 'screen not found'}, status: :not_found
      else
        render json: screens
      end
    else
      render json: { message: 'theatre not found' }, status: :not_found  
    end
  end

  private

  def screen_params
    params.permit(:theatre_id, :seating_capacity, :movie_id)
  end

  def check_user
    if !@current_user.user
      render json: { error: 'not Allowed' }
    end
  end
end
