# frozen_string_literal: true

# managing ticket
class TicketsController < ApiController
  before_action :check_user
  # Service to download ftp files from the
  def create
    number_of_tickets = params[:number_of_tickets].to_i
    tickets = []
    theatre = Theatre.find_by_id(params[:theatre_id])
    movie = Movie.find_by_id(params[:movie_id])
    if theatre.nil? || movie.nil?
      render json: {message: 'please give a valid movie or theatre'}
    else

      screen = Screen.find_by(movie_id: params[:movie_id], theatre_id: params[:theatre_id])
      if screen.seating_capacity < number_of_tickets
        return render json: { error: 'screen do not have space for ticket' }, status: :unprocessable_entity
      end
      ticket_details = @current_user.tickets.new(ticket_params)
      if ticket_details.save
        tickets << ticket_details
        screen.update(seating_capacity: screen.seating_capacity - number_of_tickets)
        render json: tickets, status: :created
      else
        render json: { error: ticket_details.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  
  def show
    tickets = Ticket.find_by(alphanumeric_id: params[:id])
    if tickets.present?
      render json: tickets
    else
      render json: { error: 'ticket not found' }
    end
	end

  def index
    ticket = @current_user.tickets
    if ticket.present?
      render json: ticket
    else
      render json: { message: 'ticket not found' }
    end
  end

  private

  def ticket_params
    params.permit(:movie_id, :user_id, :theatre_id,:number_of_tickets)
  end

  def check_user
    if @current_user.user
      render json: { error: 'not Allowed' }
    end
  end
end