# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

# Encapsulates interaction with the Freshtrak Registration API
class FreshtrakRegistrationApi
    BASE_URL = 'api'

    def initialize(url: Config.freshtrak_registration_api_url)
        @url = url
    end

    private
    def client
        @client ||=
        Faraday.new(url: @url) do |config|
            config.request :json
            config.response :raise_error
            config.response :json, parser_options: { symbolize_names: true },
                                    content_type: /\bjson$/
            config.adapter Faraday.default_adapter
        end
    end

end