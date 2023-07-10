class Screen < ApplicationRecord
  belongs_to :theatre
  has_one :movie
end
