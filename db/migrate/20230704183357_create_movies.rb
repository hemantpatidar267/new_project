class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.references :user, null: true, foreign_key: true
      t.references :screen, null: true, foreign_key: true
      t.string :name
      t.string :start_date
      t.string :end_date

      t.timestamps
    end
  end
end
