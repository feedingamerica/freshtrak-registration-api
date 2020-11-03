# frozen_string_literal: true

module Twilio
  # Creates Twilio client: sends text messages for users
  class Sms
    attr_reader :sender, :recipent, :message

    def initialize(sender, recipent, message)
      @sender = sender
      @recipent = recipent
      @message = message
    end

    def call
      begin
        return success if send_sms
      rescue Twilio::REST::RestError => e
        Jets.logger.error "Problem accessing Twilio service,
          Message: #{e}"
      end
      failure
    end

    def send_sms
      connection.messages.create({
                                   from: sender,
                                   to: recipent,
                                   body: message
                                 })
    end

    private

    def connection
      @connection ||= Twilio::REST::Client.new account_sid, auth_token
    end

    def account_sid
      ENV['TWILIO_ACCOUNT_SID']
    end

    def auth_token
      ENV['TWILIO_AUTH_TOKEN']
    end

    def failure
      OpenStruct.new(success?: false)
    end

    def success
      OpenStruct.new(success?: true)
    end
  end
end
