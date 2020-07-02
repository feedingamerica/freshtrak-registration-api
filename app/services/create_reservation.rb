# frozen_string_literal: true

# Creates an event_date reservation record for a user
#   Ensures that the user has not already reserved a spot
#   Ensures that the event_date has open capacity
#   Ensures that the event_slot has open capacity
class CreateReservation
  attr_reader :user_id, :event_date_id, :event_slot_id, :reservation

  def initialize(options = {})
    @user_id = options[:user_id]
    @event_date_id = options[:event_date_id]
    @event_slot_id = options[:event_slot_id]
    @reservation = Reservation.new(options)
  end

  def call
    return failure if user_already_has_reservation? || event_is_at_capacity?

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
      if event_slot_id.present?
        reservation.errors.add(:event_slot_id, 'is at capacity')
      else
        reservation.errors.add(:event_date_id, 'is at capacity')
      end
    end

    event_is_at_capacity
  end

  def event_capacity
    if event_slot_id.present?
      PantryFinderApi.new.event_slot(event_slot_id)[:capacity]
    else
      PantryFinderApi.new.event_date(event_date_id)[:capacity]
    end
  end

  def event_reservations
    @event_reservations ||= if event_slot_id.present?
                              Reservation.by_event_slot_id(event_slot_id)
                            else
                              Reservation.by_event_date_id(event_date_id)
                            end
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
