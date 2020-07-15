# frozen_string_literal: true

# Migration to add Event Status ID Foreign Key to Event Registrations
class AddEventStatusToEventRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :event_registrations, :event_status_id, :bigint
    add_foreign_key :event_registrations, :event_statuses
  end
end
