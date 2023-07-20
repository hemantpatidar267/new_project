# frozen_string_literal: true

# managing theatre
class TheatresController < ApiController
  before_action :check_user, only: [:create, :update]
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
    theatre =  Theatre.find_by(id: params[:id])
    if theatre.present?
      render json: theatre, status: :ok
    else
       render json: { message: 'theatre not found' }
    end
  end

  def update
    theatre = @current_user.theatres.find_by(id: params[:id])
    if theatre.update(theatre_params)
      render json: theatre , status: :ok
    end
    rescue NoMethodError
        render json: { message: 'theatre not found' }
  end

  def search_theatre_by_movie
    movie = Movie.find_by(id: params[:movie_id])
    if movie.present?
      theatres = movie.theatres
      if theatres.empty?
        render json: { message: 'theatre not found'},status: 400
      else
        render json: theatres
      end
    else
      render json: { message: 'movie not found' }
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

  def check_user
    if !@current_user.user
      render json: { error: 'not Allowed' }
    end
  end
end
