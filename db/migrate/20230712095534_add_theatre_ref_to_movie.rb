class AddTheatreRefToMovie < ActiveRecord::Migration[7.0]
  def change
    add_reference :movies, :theatre, foreign_key: true
  end
end
