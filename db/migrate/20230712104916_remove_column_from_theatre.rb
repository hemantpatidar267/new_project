class RemoveColumnFromTheatre < ActiveRecord::Migration[7.0]
  def change
    remove_column :theatres, :image, :binary
  end
end
