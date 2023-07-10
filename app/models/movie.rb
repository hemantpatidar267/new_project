class Movie < ApplicationRecord	
	belongs_to :screen
	belongs_to :user
	has_many :tickets
    
    validates :screen_id, presence: true, uniqueness: true

end
