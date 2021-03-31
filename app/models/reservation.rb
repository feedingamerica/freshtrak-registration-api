# frozen_string_literal: true

# Reserves a slot at an agency event for a user
class Reservation < ApplicationRecord
  belongs_to :user, inverse_of: :reservations
  # after_commit :sync_to_pantry_trak, on: :create

  private

  def sync_to_pantry_trak
    PantryTrak::Client.new.create_reservation(
      id, user_id, event_date_id, event_slot_id
    )
  end
end
