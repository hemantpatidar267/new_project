class Theatre < ApplicationRecord
  belongs_to :user
  has_many :screens
  has_many :tickets
  has_many :movies ,through: :screens
  # has_many :showtimes
  # has_many :movies, through: :showtimes

  has_one_attached :image
  
  validates :name , presence: true
  validates :address , presence: true

   def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "id", "name", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "movies", "screens", "showtimes", "tickets", "user"]
  end
end
