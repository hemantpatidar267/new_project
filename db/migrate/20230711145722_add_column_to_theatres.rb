class AddColumnToTheatres < ActiveRecord::Migration[7.0]
  def change
    add_column :theatres, :image, :binary
  end
end
