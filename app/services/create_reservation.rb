class CreateReservation
  attr_reader :user_id, :event_date_id, :reservation

  def initialize(user_id:, event_date_id:)
    @user_id = user_id
    @event_date_id = event_date_id
    @reservation = Reservation.new(user_id: user_id,
                                   event_date_id: event_date_id)
  end

  def call
    if event_reservations.where(user_id: user_id).exists?
      reservation.errors.add(:user_id, 'has already registered for this event')
      return failure
    end

    if event_capacity <= event_reservations.count
      reservation.errors.add(:event_date_id, 'is at capacity')
      return failure
    end

    return failure unless reservation.save

    success
  rescue Faraday::Error => exception
    reservation.errors.add(:pantry_finder_api, exception.message)
    failure
  end

  private

  def event_capacity
    PantryFinderApi.new.event_date(event_date_id)[:capacity]
  end

  def event_reservations
    @event_reservations ||= Reservation.where(event_date_id: event_date_id)
  end

  def failure
    OpenStruct.new(success?: false, reservation: reservation)
  end

  def success
    OpenStruct.new(success?: true, reservation: reservation)
  end
end
