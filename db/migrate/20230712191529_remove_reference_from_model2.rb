class RemoveReferenceFromModel2 < ActiveRecord::Migration[7.0]
  def change
    remove_reference :movies, :theatre, foreign_key: true
  end
end
