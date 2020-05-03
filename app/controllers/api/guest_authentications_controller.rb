# frozen_string_literal: true

module Api
  # Create a temporary guest user and authentication
  class GuestAuthenticationsController < Api::BaseController
    skip_before_action :authenticate_user!
    before_action :set_guest_user

    # POST /api/guest_authentications
    def create
      @authentication = @guest_user.authentications.new

      if @guest_user.save
        render json: @authentication, status: :created
      else
        render json: @authentication.errors, status: :unprocessable_entity
      end
    end

    private

    def set_guest_user
      @guest_user = User.new(user_type: :guest)
    end
  end
end
