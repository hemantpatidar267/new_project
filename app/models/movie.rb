class Movie < ApplicationRecord	
	has_many :screens
	belongs_to :user
	has_many :tickets
  # has_many :showtimes
  has_many :theatres, through: :screens
    
    # validates :screen_id, presence: true, uniqueness: true
  validates :name , presence: true
  validates :start_date , presence: true
  validates :end_date , presence: true


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "end_date", "id", "name", "start_date", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["screens", "showtimes", "theatres", "tickets", "user"]
  end

end
