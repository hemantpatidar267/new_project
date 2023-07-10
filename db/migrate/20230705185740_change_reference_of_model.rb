class ChangeReferenceOfModel < ActiveRecord::Migration[7.0]
  def change
    change_table :tickets do |t|
      t.remove :theater_id
      t.references :theatre, null: false, foreign_key: true
    end
  end
end
