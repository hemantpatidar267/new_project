class TheatresController < ApplicationController
  before_action :authorize_owner, only: [:create, :update, :destroy]

  def create
    theatre = @current_user.theatres.new(theatre_params)

    if theatre.save
      render json: theatre, status: :created
    else
      render json: theatre.errors, status: :unprocessable_entity
    end
  end


  def show
    theatre = Theatre.find_by(id:params[:id])
    render json: { theatre: theatre }
  end


  def update
    #byebug
    if theatre = Theatre.find_by(id: params[:id])

      if theatre.update(theatre_params)
        render json: theatre, status: :ok
      else
        render json: theatre.errors, status: :unprocessable_entity
      end
    else
      render json: {error: "please provide valid theatre id"},status: :unprocessable_entity
    end  
  end


  def destroy
    if theatre = Theatre.find_by(id: params[:id])

      if theatre.destroy
        render json: { message: "Theatre successfully deleted" }, status: :ok
      else
        render json: { error: "Failed to delete theatre" }, status: :unprocessable_entity
      end
    else
      render json: {error: "please provide valid theatre id"},status: :unprocessable_entity
    end  
  end





  def index
    theaters = Theatre.all
    result = []
    theaters.each do |t|
      h = Hash.new
      h[:title] = t.name
      h[:address] = t.address
      #h[:user_id] = t.user_id
      result.push(h)
    end
      render json: result
  end


  private

  def theatre_params
    params.require(:theatre).permit(:name ,:address)
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
