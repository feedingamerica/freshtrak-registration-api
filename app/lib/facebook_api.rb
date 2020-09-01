# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

# Encapsulates interaction with the FACEBOOK API
class FacebookApi
  def initialize(url: Config.facebook_api_url)
    @url = url
  end

  def facebook_auth(token, user_id)
    link =
      "/debug_token?input_token=#{token}&access_token=#{app_id}|#{app_secret}"
    response = client.get(link)
    response.body[:data][:user_id] == user_id
  end

  private

  def client
    @client ||=
      Faraday.new(url: @url) do |config|
        config.request :json
        config.response :json, parser_options: { symbolize_names: true },
                               content_type: /\bjson$/
        config.adapter Faraday.default_adapter
      end
  end

  def app_id
    ENV['FACEBOOK_APP_ID']
  end

  def app_secret
    ENV['FACEBOOK_APP_SECRET']
  end
end
