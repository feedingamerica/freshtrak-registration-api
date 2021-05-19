# frozen_string_literal: true

module Api
  # Exposes the Emails of user
  class EmailsController < Api::BaseController
    before_action :find_person, only: %i[update]

    # PUT /phone/1
    def update
      @email = @person.emails.first

      if @email.update(email_params)
        render json: @email
      else
        render json: @email.errors, status: :unprocessable_entity
      end
    end

    private

    def find_person
      @person = current_user.person
    end

    def email_params
      params.permit(:email, :permission_to_email)
    end
  end
end
