class AddEventStatusToEventRegistration < ActiveRecord::Migration[6.0]
  def change
    add_reference :event_registrations, :event_status, foreign_key: true, null: false
  end
end
