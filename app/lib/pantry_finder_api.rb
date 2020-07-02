# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

# Encapsulates interaction with the Pantry Finder API
class PantryFinderApi
  BASE_URL = 'api'

  def initialize(url: Config.pantry_finder_api_url)
    @url = url
  end

  def event_date(id)
    client.get("#{BASE_URL}/event_dates/#{id}").body[:event_date]
  end

  def event_slot(id)
    client.get("#{BASE_URL}/event_slots/#{id}").body[:event_slot]
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
