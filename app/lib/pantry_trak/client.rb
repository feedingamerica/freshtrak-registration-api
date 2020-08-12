# frozen_string_literal: true

module PantryTrak
  # Creates PantryTrak client: handling of reservartions and users
  # For user details, see pantry_trak/users.rb
  class Client
    def create_user(user)
      connection.post(create_user_path, user.to_json) do |req|
        req.headers['Authorization'] = bearer_token
      end.body
    rescue Faraday::Error => e
      handle_unsucessful_response(e)
    end

    def create_reservation(id, user_id, event_date_id, event_slot_id = nil)
      payload = {
        id: id, user_id: user_id,
        event_date_id: event_date_id, event_slot_id: event_slot_id
      }.compact
      connection.post(create_reservation_path, payload) do |req|
        req.headers['Authorization'] = bearer_token
      end.body
    rescue Faraday::Error => e
      handle_unsucessful_response(e)
    end

    private

    def connection
      @connection ||= Faraday.new(base_url) do |c|
        c.request :json
        c.response :json
        c.adapter Faraday.default_adapter
      end
    end

    def bearer_token
      payload = {
        token: public_token,
        time: Time.now.to_i
      }
      "Bearer #{JWT.encode(
        payload, hmac_secret, 'HS256', { alg: 'HS256', typ: 'JWT' }
      )}"
    end

    def hmac_secret
      ENV['PANTRY_TRAK_SECRET']
    end

    def public_token
      ENV['PANTRY_TRAK_TOKEN']
    end

    def base_url
      ENV['PANTRY_TRAK_API_URL']
    end

    def create_user_path
      if Jets.env.production?
        'api/create_freshtrak_user.php'
      else
        'api/create_freshtrak_user_beta.php'
      end
    end

    def create_reservation_path
      if Jets.env.production?
        'api/create_freshtrak_reservation.php'
      else
        'api/create_freshtrak_reservation_beta.php'
      end
    end

    def handle_unsucessful_response(response)
      # TODO: In order to rescue the very specific exceptions,
      # refs# https://github.com/lostisland/faraday/blob/master/lib/faraday/error.rb
      # Trying to handle exception and print on logs
      Jets.logger.info '_' * 10
      Jets.logger.error "Problem accessing PantryTrak web service,
        Message: #{response.message}"
      Jets.logger.info '_' * 10
    end
  end
end
