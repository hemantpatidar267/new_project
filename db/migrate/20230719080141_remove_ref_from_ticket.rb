class RemoveRefFromTicket < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tickets ,:screen ,foreign_key: true
  end
end
