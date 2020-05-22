# frozen_string_literal: true

# Module for storing global configuration
module Config
    class << self
      def freshtrak_registration_api_url
        @freshtrak_registration_api_url ||= ENV.fetch('FRESHTRAK_REGISTRATION_API_URL')
      end
    end
  end