class Theatre < ApplicationRecord
  belongs_to :user
  has_many :screens
  has_many :tickets
  has_many :movies
  has_many :showtimes
  has_many :movies, through: :showtimes

  # has_one_attacted :image
  
  validates :name , presence: true
  validates :address , presence: true
end
