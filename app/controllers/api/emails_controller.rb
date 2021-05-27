# frozen_string_literal: true

module Api
  # Exposes the Emails of user
  class EmailsController < Api::BaseController
    before_action :set_email, only: %i[update show]

    # PUT/POST/PATCH  /api/email
    def update
      if @email.update(email_params)
        render json: @email
      else
        render json: @email.errors, status: :unprocessable_entity
      end
    end

    # GET /api/email
    def show
      render json:
        ActiveModelSerializers::SerializableResource
          .new(@email).as_json
    end

    private

    def set_email
      person = current_user.person
      family = Family.by_person_id(person.id).first
      @email = family.contacts.email.first.email
    end

    # Only allow a trusted parameter "white list" through.
    def email_params
      params.require(:email).permit(:email, :permission_to_email)
    end
  end
end
