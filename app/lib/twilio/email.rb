# frozen_string_literal: true

module Twilio
  # send email using Twilio SendGrid Services.
  class Email
    attr_reader :from, :subject, :to, :content

    def initialize(from, subject, to, content)
      @from = email(from)
      @subject = subject
      @to = email(to)
      @content = SendGrid::Content.new(type: 'text/html', value: content)
    end

    def call
      if send_email.status_code == '202'
        success
      else
        Jets.logger.error 'Problem accessing Twilio SendGrid API Service'
        failure
      end
    end

    def send_email
      mail = SendGrid::Mail.new(from, subject, to, content)
      response = sg_api.client.mail._('send').post(request_body: mail.to_json)
      response
    end

    private

    def email(target)
      SendGrid::Email.new(email: target)
    end

    def sg_api
      @sg_api ||= SendGrid::API.new(api_key: sendgrid_api_key)
    end

    def sendgrid_api_key
      Config.sendgrid_api_key
    end

    def failure
      OpenStruct.new(success?: false)
    end

    def success
      OpenStruct.new(success?: true)
    end
  end
end
