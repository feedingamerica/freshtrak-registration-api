# frozen_string_literal: true

# Module for storing global configuration
module Config
  class << self
    def pantry_finder_api_url
      @pantry_finder_api_url ||= ENV.fetch('PANTRY_FINDER_API_URL')
    end

    def facebook_api_url
      @facebook_api_url ||= ENV.fetch('FACEBOOK_API_URL')
    end

    def sendgrid_api_key
      @sendgrid_api_key ||= ENV.fetch('SENDGRID_API_KEY')
    end
  end
end
