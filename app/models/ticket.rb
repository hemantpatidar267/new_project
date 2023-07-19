class Ticket < ApplicationRecord
  belongs_to :movie
  # belongs_to :screen
  belongs_to :user
  belongs_to :theatre

  validates :movie_id , presence: true
  validates :theatre_id , presence: true
  validates :number_of_tickets , presence: true

  before_save :ticket_id

  def ticket_id
    self.alphanumeric_id = SecureRandom.hex[0..8]
  end

  
  def self.ransackable_attributes(auth_object = nil)
    ["alphanumeric_id", "created_at", "id", "movie_id", "number_of_tickets", "theatre_id", "updated_at", "user_id"]
  end
end