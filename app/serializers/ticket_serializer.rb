class TicketSerializer < ActiveModel::Serializer
  attributes :id, :movie_id, :theatre_id, :screen_id, :user_id, :alphanumeric_id, :number_of_tickets
end
