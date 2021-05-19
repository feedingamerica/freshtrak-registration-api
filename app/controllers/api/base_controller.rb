# frozen_string_literal: true

module Api
  # Base controller for api namespace
  class BaseController < ApplicationController
    before_action :authenticate_user!

    private

    attr_reader :current_user

    def authenticate_user!
      return if current_authentication?

      render json: { error: 'invalid_auth' }, status: :unauthorized
    end

    def current_authentication?
      @token = request.headers['authorization']
      return false if @token.blank?

      authenticate_token(@token)
    end

    def authenticate_token(token)
      @auth = CognitoApi.new.parse_cognito_token(token)
      identity = Identity.find_by(provider_uid: @auth['sub'])
      @current_user = identity.user if identity

      @auth
    end
  end
end
