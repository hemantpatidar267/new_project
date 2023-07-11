class Movie < ApplicationRecord	
	belongs_to :screen
	belongs_to :user
	has_many :tickets
    
    validates :screen_id, presence: true, uniqueness: true
    validates :name , presence: true
    validates :start_date , presence: true
    validates :end_date , presence: true

end
