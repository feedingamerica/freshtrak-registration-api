# frozen_string_literal: true

# Creates an event_date reservation record for a user
#   Ensures that the user has not already reserved a spot
#   Ensures that the event_date has open capacity
class CreateReservation
  attr_reader :user_id, :event_date_id, :event_slot_id, :reservation

  def initialize(options = {})
    @user_id = options[:user_id]
    @event_date_id = options[:event_date_id]
    @reservation = Reservation.new(options)
  end

  def call
    return failure if user_already_has_reservation?

    return failure if event_is_at_capacity?

    return failure unless reservation.save

    success
  rescue Faraday::Error => e
    reservation.errors.add(:pantry_finder_api, e.message)
    failure
  end

  private

  def user_already_has_reservation?
    user_already_has_reservation =
      event_reservations.where(user_id: user_id).exists?

    if user_already_has_reservation
      reservation.errors.add(:user_id, 'has already registered for this event')
    end

    user_already_has_reservation
  end

  def event_is_at_capacity?
    event_is_at_capacity = event_reservations.count >= event_capacity

    if event_is_at_capacity
      reservation.errors.add(:event_date_id, 'is at capacity')
    end

    event_is_at_capacity
  end

  def event_capacity
    PantryFinderApi.new.event_date(event_date_id)[:capacity]
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
