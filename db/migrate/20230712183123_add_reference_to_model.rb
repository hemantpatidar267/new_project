class AddReferenceToModel < ActiveRecord::Migration[7.0]
  def change
    add_reference :screens, :movie, foreign_key: true
  end
end
