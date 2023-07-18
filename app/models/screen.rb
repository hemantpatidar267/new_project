class Screen < ApplicationRecord
  belongs_to :theatre
  has_one :movie
  belongs_to :movie
  has_many :tickets, dependent: :destroy

  validates :theatre_id , presence: true
  validates :seating_capacity , presence: true
end
