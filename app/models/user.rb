class User < ApplicationRecord
	has_many :theatres
	has_many :movies
	has_many :tickets
	has_many :theatres
  has_many :screens, through: :theatres
	#has_secure_password
	validates :name, presence: true, format: {without: /\d/}
	validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
	validates :password , presence: true
	validates :role, presence: true

	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "password", "role", "updated_at", "user"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["movies", "theatres", "tickets"]
  end

end
