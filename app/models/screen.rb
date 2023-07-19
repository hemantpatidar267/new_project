class Screen < ApplicationRecord
  belongs_to :theatre
  has_one :movie
  belongs_to :movie
  has_many :theatres
  has_many :users, through: :theatres
  # has_many :tickets, dependent: :destroy
  

  validates :theatre_id , presence: true
  validates :seating_capacity , presence: true
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "movie_id", "seating_capacity", "theatre_id", "updated_at"]
  end
end
