class Theatre < ApplicationRecord
  belongs_to :user
  has_many :screens
  has_many :tickets
end
