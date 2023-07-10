class Ticket < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  belongs_to :user
  belongs_to :theatre
end
