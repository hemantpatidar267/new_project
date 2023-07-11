class Theatre < ApplicationRecord
  belongs_to :user
  has_many :screens
  has_many :tickets

  validates :name , presence: true
  validates :address , presence: true
end
