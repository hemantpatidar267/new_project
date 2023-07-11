class Screen < ApplicationRecord
  belongs_to :theatre
  has_one :movie

  validates :theatre_id , presence: true
  validates :seating_capacity , presence: true
end
