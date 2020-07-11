# frozen_string_literal: true

module PantryTrak
  # Creates PantryTrak client: handling of reservartions and users
  # For user details, see pantry_trak/users.rb
  class Client
    def create_user(user)
      raise 'Requires PantryTrak::User' unless user.instance_of? PantryTrak::User
      raise user.errors.full_messages.to_sentence unless user.valid?

      connection.post(create_user_path, user.to_json) do |req|
        req.headers['Authorization'] = bearer_token
      end.body
    end

    def create_reservation(id, user_id, event_date_id, event_slot_id)
      payload = {
        id: id,
        user_id: user_id,
        event_date_id: event_date_id,
        event_slot_id: event_slot_id
      }
      connection.post(create_reservation_path, payload) do |req|
        req.headers['Authorization'] = bearer_token
      end.body
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
      "Bearer #{JWT.encode(payload, hmac_secret, 'HS256', { typ: 'JWT' })}"
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
  end
end
