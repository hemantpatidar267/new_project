class ScreensController < ApplicationController
  before_action :check_user, only: [:create, :update, :destroy]

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
    screen= Screen.find_by(id: params[:id])
    render json: screen
  end

  def update
    if screen = Screen.find_by(id: params[:id])
      show = Showtime.find_by(movie_id: screen.movie_id, theatre_id: screen.theatre_id)
      if screen.update(screen_params)
        show.movie_id = screen.movie_id
        show.save
        render json: screen, status: :ok
      else
        render json: screen.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'please provide valid screen id' },status: :unprocessable_entity
    end  

  end
  
  def destroy
    if screen = Screen.find_by(id: params[:id])

      if screen.destroy
        render json: { message: 'screen successfully deleted' }, status: :ok
      else
        render json: { error: 'Failed to delete screen' }, status: :unprocessable_entity
      end
    else
      render json: {error: 'please provide valid screen id' },status: :unprocessable_entity
    end  
  end
  
  def index
    theatre = Theatre.find_by(id: params[:id])
    screens = theatre.screens
    render json: screens
  end

  private

  def screen_params
    params.require(:screen).permit(:theatre_id, :seating_capacity, :movie_id)
  end
  def show_params
    params.require(:screen).permit(:theatre_id, :movie_id)
  end

  def check_user
    # byebug
    if !@current_user.user
      render json: {error: "not Allowed"}
    end
  end

  # def authorize_owner
  #   theatre =  Theatre.find_by(id: @current_user.id)
  #   if theatre.user
  #     if theatre.user.user
  #       puts theatre.user.user
  #     else
  #       render json: { error: "you do not have powers" }, status: :unauthorized
  #     end
  #   else
  #     render json: { error: "you are not a valid user" }, status: :unauthorized
  #   end
  # end
end
