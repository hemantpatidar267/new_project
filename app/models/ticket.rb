class Ticket < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  belongs_to :user
  belongs_to :theatre

  validates :movie_id , presence: true
  validates :theatre_id , presence: true
  validates :number_of_tickets , presence: true
end
