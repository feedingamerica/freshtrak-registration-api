# frozen_string_literal: true

# Create a external user and authentication from server side.
class AuthCallbacksController < ApplicationController
  before_action :verify_facebook_auth, only: %i[facebook]

  def facebook
    @identity = Identity.find_by(identity_params)
    if @identity
      @current_user = @identity.user
      @authentication = @current_user.authentications
    else
      response = ProviderServices.new(identity_params).call
      @current_user = response.current_user
      @authentication = response.authentication
    end
    render json: @authentication
  end

  private

  def identity_params
    {
      'provider_uid': params['userID'],
      'provider': params['graphDomain']
    }
  end

  def verify_facebook_auth
    FacebookApi.new.facebook_auth(params['accessToken'], params['userID'])
  end
end
