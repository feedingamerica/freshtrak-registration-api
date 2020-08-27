# frozen_string_literal: true

# Creates an identity, user, authentication records for external users
class ProviderServices
  attr_reader :provider_uid, :provider

  def initialize(provider_uid:, provider:)
    @current_user = User.new(user_type: :facebook)
    @identities = @current_user.identities.new(
      provider_uid: provider_uid,
      provider: provider
    )
    @authentication = @current_user.authentications.new
  end

  def call
    return success if @current_user.save
  end

  def success
    OpenStruct.new(success?: true, authentication: @authentication,
                   current_user: @current_user, errors: nil)
  end
end
