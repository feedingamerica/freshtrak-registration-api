# frozen_string_literal: true

# Creates an event_date reservation record for a user
#   Ensures that the user has not already reserved a spot
#   Ensures that the event_date has open capacity
#   Ensures that the event_slot has open capacity
class CreateReservation
  attr_reader :user_id, :event_date_id, :event_slot_id, :reservation

  def initialize(user_id:, event_date_id:, event_slot_id: nil)
    @user_id = user_id
    @event_date_id = event_date_id
    @event_slot_id = event_slot_id
    @reservation = Reservation.new(user_id: user_id,
                                   event_date_id: event_date_id,
                                   event_slot_id: event_slot_id)
  end

  def call
    begin
      check_if_user_already_has_reservation
      check_if_event_date_at_capacity
      check_if_valid_event_slot

      return success if reservation.errors.empty? && reservation.save
    rescue Faraday::Error => e
      reservation.errors.add(:pantry_finder_api, e.message)
    end

    failure
  end

  private

  def check_if_user_already_has_reservation
    user_already_has_reservation =
      event_reservations.where(user_id: user_id).exists?

    return unless user_already_has_reservation

    reservation.errors.add(:user_id, 'has already registered for this event')
  end

  def check_if_event_date_at_capacity
    event_date_at_capacity =
      event_reservations.count >= event_date[:capacity]

    return unless event_date_at_capacity

    reservation.errors.add(:event_date_id, 'is at capacity')
  end

  def check_if_valid_event_slot
    return unless event_slot_id

    if event_slot && event_slot_at_capacity?
      reservation.errors.add(:event_slot_id, 'is at capacity')
    elsif !event_slot
      reservation.errors.add(:event_slot_id, 'is not for event date')
    end
  end

  def event_slot_at_capacity?
    event_slot_reservations =
      event_reservations.where(event_slot_id: event_slot_id)

    event_slot_reservations.count >= event_slot[:capacity]
  end

  def event_date
    @event_date ||= PantryFinderApi.new.event_date(event_date_id)
  end

  def event_slot
    @event_slot ||=
      event_date[:event_hours].map { |eh| eh[:event_slots] }.flatten
                              .find { |es| es[:event_slot_id] == event_slot_id }
  end

  def event_reservations
    @event_reservations ||= Reservation.where(event_date_id: event_date_id)
  end

  def failure
    OpenStruct.new(success?: false, reservation: reservation,
                   errors: reservation.errors)
  end

  def success
    OpenStruct.new(success?: true, reservation: reservation,
                   errors: nil)
  end
end
