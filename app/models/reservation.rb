# frozen_string_literal: true

# Reserves a slot at an agency event for a user

require 'net/http'

class Reservation < ApplicationRecord
  belongs_to :user, inverse_of: :reservations
  # after_commit :sync_to_pantry_trak, on: :create

  def self.send_remainders
    start_time = Time.current + 1.day
    puts start_time
    message = 'FreshTrak Remainder: You have successfully ' \
      'registered for FreshTrak'
    event_dates = {}

    reservations = Reservation.where({ remainder_sent: false })
    reservations.each do |reservation|
      details = { reservation: reservation, event_dates: event_dates,
                  start_time: start_time, message: message }
      event_dates = send_reservstion_remainder(details)
    end
  end

  def self.send_reservstion_remainder(details)
    event_date_id = details[:reservation].event_date_id.to_s
    event_dates = details[:event_dates]

    unless event_dates[event_date_id]
      event_dates = fetch_event_info(event_dates, event_date_id)
    end

    if event_dates[event_date_id]
      details[:event_date_data] = event_dates[event_date_id]
      check_and_send_remainder(details)
    end

    event_dates
  end

  def self.check_and_send_remainder(details)
    phone = details[:reservation].user.try(:phone)

    event_date_data = details[:event_date_data]
    event_date = event_date_data[:event_date]

    event_time = get_event_time(event_date)
    send_sms =  event_time >= details[:start_time] &&
                event_time <= (details[:start_time] + 4.minutes)

    send_remainder(event_date_data[:twilio_phone_number], phone,
                   details[:message], send_sms)
  end

  def self.get_event_time(event_date)
    start_time = event_date['start_time']
    time_string = start_time.include?(':') ? '%I:%M %p' : '%I %p'
    Time.strptime("#{event_date['date']} #{start_time}",
                  "%F #{time_string}")
  end

  def self.send_remainder(from, to, message, send_sms)
    Twilio::Sms.new(from, to, message).call if to && send_sms
  end

  def self.fetch_event_info(event_dates, event_date_id)
    uri = URI('http://localhost:8888/api/events?event_date_id=' + event_date_id)
    res = Net::HTTP.get_response(uri)
    event_dates[event_date_id] = false

    if res.is_a?(Net::HTTPSuccess)
      events = JSON.parse(res.body)['events']
      unless events.empty?
        return update_cached_event_details(event_dates, event_date_id, events)
      end
    end

    event_dates
  end

  def self.update_cached_event_details(event_dates, event_date_id, events)
    event_date = events[0]['event_dates'].try(:[], 0)
    if event_date
      event_dates[event_date_id] = {
        event_date: event_date,
        twilio_phone_number: events[0]['twilio_phone_number']
      }
    end

    event_dates
  end

  private

  def sync_to_pantry_trak
    PantryTrak::Client.new.create_reservation(
      id, user_id, event_date_id, event_slot_id
    )
  end
end
