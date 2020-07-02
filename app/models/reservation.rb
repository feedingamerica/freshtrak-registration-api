# frozen_string_literal: true

# Reserves a slot at an agency event for a user
class Reservation < ApplicationRecord
  belongs_to :user, inverse_of: :reservations

  scope :by_event_date_id, ->(id) { where(event_date_id: id) }
  scope :by_event_slot_id, ->(id) { where(event_slot_id: id) }
end
