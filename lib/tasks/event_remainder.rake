require 'net/http'

namespace :event do 
	desc 'event remainder'
	task :event_remainder => :environment do
	  	puts "remainder messgae"
	  	start_time = Time.current + 1.day
	 	message = "FreshTrak Remainder: You have successfully registered for FreshTrak"

	 	event_dates = {}
	  	
	  	reservations = Reservation.where({remainder_sent: false})
		reservations.each do |reservation|
			event_date_id = reservation.event_date_id.to_s

			unless event_dates[event_date_id]
				uri = URI("http://localhost:8888/api/events?event_date_id=" + event_date_id)
				res = Net::HTTP.get_response(uri)
				puts res.body.inspect
				if res.is_a?(Net::HTTPSuccess)
					events = JSON.parse(res.body)["events"]
					if events.empty?
						event_dates[event_date_id] = false
					else
						event_date = events[0]["event_dates"].try(:[], 0)
						event_dates[event_date_id] = event_date ? {event_date: event_date, twilio_phone_number: events[0]['twilio_phone_number']} : false
					end
				else
					event_dates[event_date_id] = false
				end
			end

			user = reservation.user 
			phone = user.phone
			send_sms = false
			puts "Phone Number #{user.phone}"


			if event_dates[event_date_id]
				event_date_data = event_dates[event_date_id]
				event_date = event_date_data[:event_date]
				event_start_time = event_date['start_time']
				puts "event date #{event_date}"

				event_time = Time.strptime("#{event_date['date']} #{event_start_time}", "%F #{event_start_time.include?(':') ? '%I:%M %p' : '%I %p' }")
puts event_time
puts start_time
				send_sms = event_time >= start_time && event_time <= (start_time + 4.minutes)
				puts "send_sms  #{send_sms} "

				if phone && send_sms
					Twilio::Sms.new(
				      event_date_data[:twilio_phone_number] , phone, message
				    ).call
				    puts "Sending message to #{user.inspect}"
				end
			end
		end
	end

end
