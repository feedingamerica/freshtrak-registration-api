# frozen_string_literal: true

module Api
  # Exposes the Addresses of user
  class PhonesController < Api::BaseController
    before_action :find_person, only: %i[update]

    # PUT /phone/1
    def update
      @phone = @person.phones.first

      if @phone.update(phone_params)
        render json: @phone
      else
        render json: @phone.errors, status: :unprocessable_entity
      end
    end

    private

    def find_person
      @person = current_user.person
    end

    def phone_params
      params.permit(:phone, :permission_to_text)
    end
  end
end
