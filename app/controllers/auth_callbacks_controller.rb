# frozen_string_literal: true

# Create a external user and authentication from server side.
class AuthCallbacksController < ApplicationController
  def facebook
    verify_facebook_auth

    @identity = Identity.find_by(identity_params)
    if @identity
      set_user_authentications
    else
      create_user_authentications
    end
    render json: @authentication
  rescue StandardError => e
    render json: handle_unsucessful_response(e), status: :unprocessable_entity
  end

  private

  def identity_params
    {
      'provider_uid': params['userID'],
      'provider_type': params['graphDomain'],
      'auth_hash': params['accessToken']
    }
  end

  def set_user_authentications
    @current_user = @identity.user
    @authentication = @current_user.authentications
  end

  def create_user_authentications
    @current_user = User.new(user_type: :guest)
    @identities = @current_user.identities.new(identity_params)
    @authentication = @current_user.authentications.new
    @current_user.save
  end

  def verify_facebook_auth
    FacebookApi.new.facebook_auth(params['accessToken'], params['userID'])
  end

  def handle_unsucessful_response(response)
    # handle exception and logging the error.
    Jets.logger.error "Problem accessing Facebook web service,
      Message: #{response.message}"
  end
end
