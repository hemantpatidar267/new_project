# frozen_string_literal: true

# managing movie
class MoviesController < ApplicationController
  before_action :check_user, only: %i[create update destroy]
  before_action :set_movie, only: [:show, :update, :destroy]
  # Service to download ftp files from the
  def create
    movie = @current_user.movies.new(movie_params)
    if movie.save
      render json: movie, status: :created
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @movie
  end

  def search_theatre_by_movie
    movie = Movie.find_by(id: params[:movie_id])
    theatres = movie.theatres
    render json: theatres
  end

  def update
    if @movie.update(movie_params)
      render json: @movie, status: :ok
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  def movie_time
    @movies = Movie.where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    render json: @movies
  end

  def index
    query = params[:query]
    movies = Movie.where('name LIKE ?', "%#{query}%") if query.present?
    render json: movies || { error: 'movie not found ' }
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :start_date, :end_date)
  end

  def set_movie
    @movie = Movie.find_by(id: params[:id])
    render json: { message: 'movie not found' }, status: :not_found unless @movie
  end

  def check_user
    if !@current_user.user
      render json: { error: 'not Allowed' }
    end
  end
end
