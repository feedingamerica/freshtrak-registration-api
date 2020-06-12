class AddEventSlotIdFieldToReservations < ActiveRecord::Migration[6.0]
  def change
  	add_column :reservations, :event_slot_id, :integer, null: false
  end
end
