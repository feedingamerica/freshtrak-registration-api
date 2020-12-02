class AddEventRemainderToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :remainder_sent, :boolean, :default => false
  end
end
