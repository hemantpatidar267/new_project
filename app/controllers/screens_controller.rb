# frozen_string_literal: true

# managing screen
class ScreensController < ApiController
  before_action :check_user, only: %i[create update destroy]
  before_action :set_screen, only: [:show, :update, :destroy]
  # Service to download ftp files from the
  def create
    screen = Screen.new(screen_params)
    Showtime.create(show_params)
    if screen.save
      render json: screen, status: :created
    else
      render json: screen.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @screen
  end

  def update
    show = Showtime.find_by(movie_id: @screen.movie_id, theatre_id: @screen.theatre_id)
    if @screen.update(screen_params)
      show.movie_id = @screen.movie_id
      show.save
      render json: @screen, status: :ok
    else
      render json: @screen.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @screen.destroy
      render json: { message: 'screen successfully deleted' }, status: :ok
    else
      render json: { error: 'Failed to delete screen' }, status: :unprocessable_entity
    end
  end

  def index
    theatre = Theatre.find_by(id: params[:id])
    if theatre.nil?
      render json: { message: 'theatre not found'}, status: :not_found
    else
      screens = theatre.screens
      render json: screens
    end
  end

  private

  def screen_params
    params.require(:screen).permit(:theatre_id, :seating_capacity, :movie_id)
  end

  def show_params
    params.require(:screen).permit(:theatre_id, :movie_id)
  end

  def set_screen
    @screen = Screen.find_by(id: params[:id])
    render json: { message: 'screen not found' }, status: :not_found unless @screen
  end

  def check_user
    if !@current_user.user
      render json: { error: 'not Allowed' }
    end
  end
end
