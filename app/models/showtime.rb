class Showtime < ApplicationRecord
	belongs_to :movie
	belongs_to :theatre


 
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "movie_id", "theatre_id", "updated_at"]
  end
end
