# frozen_string_literal: true

module Api
  # Exposes the Household data
  class PeopleController < Api::BaseController
    before_action :set_person, only: %i[update]

    # PUT /households/[:params]
    def update
      if @person.update(person_params)
        render json: @person
      else
        render json: @person.errors, status: :unprocessable_entity
      end
    end

    private

    def set_person
      @person = current_user.person
    end

    def person_params
      params.permit(:id, :first_name)
    end
  end
end
