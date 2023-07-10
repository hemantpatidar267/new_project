class MoviesController < ApplicationController
  before_action :authorize_owner ,only: [:create]

  def create
    movie = @current_user.movies.new(movie_params)

    if movie.save
      render json: {movie: movie}, status: :created
    else
      render json: {error: movie.errors}, status: :unprocessable_entity
    end
  end

  def show
    movie = Movie.find_by(id:params[:id])
    render json: { movie: movie }
  end


  def update
    #byebug
    movie = Movie.find_by(id:params[:id])

    if movie.update(movie_params)
      render json: movie, status: :ok
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end


  def movie_time
    @movies = Movie.where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
    render json: @movies
  end

  def search_movie
    # byebug
    if params[:query] && !params[:query].empty?
      query = params[:query]
      @movies = Movie.where('name LIKE ?', "%#{query}%")
      if @movies.length != 0
        render json: @movies
      else
        render json: {error: "Movie not found!"}
      end
    else
      render json: {error: "please provide a query"}
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:screen_id,:name ,:start_date,:end_date)
  end



  def authorize_owner
    # Add your authorization logic here, e.g., checking if the current user is an owner
    # You can access the current user using the JWT token

    # Assuming you have a method to decode the JWT token and retrieve the user information
    user =  User.find_by(id: @current_user.id)
    if user
      if user.user
        puts user.user
      else
        render json: { error: "you do not have powers" }, status: :unauthorized
      end
    else
      render json: { error: "you are not a valid user" }, status: :unauthorized
    end
  end
end
