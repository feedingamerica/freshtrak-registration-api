# frozen_string_literal: true

module Api
  # Exposes the Addresses of user
  class PhonesController < Api::BaseController
    before_action :set_phone, only: %i[update show]

    # PUT/POST/PATCH  /api/phone
    def update
      if @phone.update(phone_params)
        render json: @phone
      else
        render json: @phone.errors, status: :unprocessable_entity
      end
    end

    # GET /api/phone
    def show
      render json:
        ActiveModelSerializers::SerializableResource
          .new(@phone).as_json
    end

    private

    def set_phone
      @person = current_user.person
      @primary_family = Family.by_person_id(@person.id).first
      @phone = @primary_family.contacts.phone.first.phone
    end

    # Only allow a trusted parameter "white list" through.
    def phone_params
      params.require(:phone).permit(:phone, :permission_to_text)
    end
  end
end
