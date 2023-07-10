class ChangeColumn < ActiveRecord::Migration[7.0]
  def up
    change_column :movies, :start_date, :date
    change_column :movies, :end_date, :date
  end

  def down
    change_column :movies, :start_date, :string
    change_column :movies, :end_date, :string
  end
end
