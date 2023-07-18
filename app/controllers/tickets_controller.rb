# frozen_string_literal: true

# managing ticket
class TicketsController < ApplicationController
  before_action :check_user
  # Service to download ftp files from the
  def create
    number_of_tickets = params[:number_of_tickets].to_i
    @tickets = []
    screen = Screen.find_by(movie_id: params[:movie_id], theatre_id: params[:theatre_id])
    if screen.seating_capacity < number_of_tickets
      render json: { error: 'screen do not have space for ticket' }, status: :unprocessable_entity
    end
    ticket_details = Ticket.new(
        movie_id: params[:movie_id],
        user_id: @current_user.id,
        theatre_id: params[:theatre_id],
        screen_id: screen.id,
        number_of_tickets: params[:number_of_tickets],
        alphanumeric_id: generate_alphanumeric_id())
    if ticket_details.save
      @tickets << ticket_details
    else
      render json: { error: ticket_details.errors.full_messages }, status: :unprocessable_entity
      return
    end
    screen[:seating_capacity] = screen[:seating_capacity] - number_of_tickets
    screen.save
    render json: @tickets, status: :created
  end
  
  def show
    @ticket = Ticket.find_by(alphanumeric_id: params[:id])
    render json: @ticket
	  rescue ActiveRecord::RecordNotFound
	    render json: { error: 'Ticket not found' }, status: :not_found
  end

  def index
    ticket = @current_user.tickets
    render json: ticket
  end

  private

  def ticket_params
    params.require(:ticket).permit(:screen_id, :movie_id, :user_id, :alphanumeric_id, :theatre_id)
  end

  def check_user
    if @current_user.user
      render json: { error: 'not Allowed' }
    end
  end

  def generate_alphanumeric_id
    alphanumeric_chars = [('A'..'Z'), ('a'..'z'), ('0'..'9')].map(&:to_a).flatten
    alphanumeric_id = Array.new(8) { alphanumeric_chars.sample }.join
    alphanumeric_id
  end
end
