class ScreensController < ApplicationController
  before_action :check_user 

  def create
    screen = Screen.new(screen_params)
    # byebug
    if screen.save
      render json: screen, status: :created
    else
      render json: screen.errors, status: :unprocessable_entity
    end
  end

  def show
    screen= Screen.find_by(id:params[:id])
    render json: { screen: screen }
  end


  def update
    #byebug
    screen = Screen.find_by(id:params[:id])

    if screen.update(screen_params)
      render json: screen, status: :ok
    else
      render json: screen.errors, status: :unprocessable_entity
    end
  end



  def index
    # byebug
    theatre = Theatre.find_by(id: params[:id])
    if theatre
      screens = theatre.screens
      result = []
      i=1;
      screens.each do |t|
        h = Hash.new
        h[:s_No] = i
        h[:seating_capacity] = t.seating_capacity
        result.push(h)
        i+=1
      end
        render json: result
    else
      render json: {error: "you search a wrong theatre"}
    end

  end

  private

  def screen_params
    params.require(:screen).permit(:theatre_id, :seating_capacity)
  end

  def check_user
    unless @current_user.user
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
