class Screen < ActiveRecord::Migration[7.0]
  def change
    drop_table :screens
  end
end
