class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :screen, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :theater, null: false, foreign_key: true
      t.string :alphanumeric_id
      t.timestamps
    end
  end
end
