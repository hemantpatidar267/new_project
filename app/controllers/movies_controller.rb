class MoviesController < ApplicationController
  before_action :authorize_owner ,only: [:create, :update, :destroy]

  def create
    #byebug
    movie = @current_user.movies.new(movie_params)

    if movie.save
      render json: movie , status: :created
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end

  def show
    #byebugs
    movie = Movie.find_by(id:params[:id])
    render json:  movie
  end

  def search_theatre_by_movie
    # byebug
    movie = Movie.find_by(id:params[:movie_id])
    theatres = movie.theatres
    render json: theatres
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



  def destroy

    if movie = Movie.find_by(id: params[:id])

      if movie.destroy
        render json: { message: "movie successfully deleted" }, status: :ok
      else
        render json: { error: "Failed to delete movie" }, status: :unprocessable_entity
      end
    else
      render json: {error: "please provide valid movie id"},status: :unprocessable_entity
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
    params.require(:movie).permit(:name, :start_date, :end_date)
  end



  def authorize_owner
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
