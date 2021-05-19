# frozen_string_literal: true

module Api
  # Exposes the Addresses of user
  class AddressesController < Api::BaseController
    before_action :find_person, only: %i[create update]

    # POST /address
    def create
      @address = @person.addresses.new(address_params)
      if @address.save
        render json: @address
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end

    # PUT /address/1
    def update
      @address = @person.addresses.first

      if @address.update(address_params)
        render json: @address
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end

    private

    def find_person
      @person = current_user.person
    end

    def address_params
      params.permit(:line_1, :line_2, :city, :state, :zip_code)
    end
  end
end
