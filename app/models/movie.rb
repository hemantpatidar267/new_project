class Movie < ApplicationRecord	
	has_many :screens
	belongs_to :user
	has_many :tickets
    has_many :showtimes
    has_many :theatres, through: :showtimes
    
    # validates :screen_id, presence: true, uniqueness: true
    validates :name , presence: true
    validates :start_date , presence: true
    validates :end_date , presence: true

end
