# frozen_string_literal: true

# Defines Reservation attributes to be returned in JSON
class ReservationSerializer < ApplicationSerializer
  attributes :user_id, :event_date_id, :event_slot_id
  attributes :license_plate, :identification_code
end
