# frozen_string_literal: true

# Create a external user and authentication from server side.
class AuthCallbacksController < ApplicationController
  def facebook
    @verify ||= verify_facebook_auth
    @identity = Identity.find_by(provider_uid: params['userID'])
    @identity ? set_user_authentications : create_user_authentications

    if @verify
      render json: @authentication
    else
      render json: {}, status: :unauthorized
    end
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
    @authentication = @current_user.authentications.first
  end

  def create_user_authentications
    @current_user = User.new(user_type: :guest)
    @identities = @current_user.identities.new(identity_params)
    @authentication = @current_user.authentications.new
    @current_user.save
  end

  def verify_facebook_auth
    FacebookApi.new.verify_facebook_token(
      params['accessToken'], params['userID']
    )
  end
end
