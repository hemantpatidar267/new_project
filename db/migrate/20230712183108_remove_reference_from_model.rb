class RemoveReferenceFromModel < ActiveRecord::Migration[7.0]
  def change
    remove_reference :movies, :screen, foreign_key: true
  end
end
