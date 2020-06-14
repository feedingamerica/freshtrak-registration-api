# frozen_string_literal: true

# Migration to add event_slot_id field to reservations table.
class AddEventSlotIdFieldToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :event_slot_id, :integer,
               null: false, default: false
  end
end
